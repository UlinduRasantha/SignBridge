from flask import Flask, request, jsonify
from flask_cors import CORS
import cv2
import numpy as np
from tensorflow import keras  # FIXED: Correct import
from keras.models import load_model
import mediapipe as mp
import base64
from io import BytesIO
from PIL import Image
import time
import traceback

app = Flask(__name__)
CORS(app)  # Enable CORS for Flutter

# Initialize MediaPipe
mp_holistic = mp.solutions.holistic
holistic = mp_holistic.Holistic(
    min_detection_confidence=0.5,
    min_tracking_confidence=0.5
)

# Load model
try:
    model = load_model('action.h5')
    print("✅ Model loaded successfully!")
    print(f"📊 Model input shape: {model.input_shape}")
    print(f"📊 Model output shape: {model.output_shape}")
except Exception as e:
    print(f"❌ Error loading model: {e}")
    traceback.print_exc()
    exit()

# Configuration
actions = np.array(['hello', 'thanks', 'ayubowan', 'alright', 'how are you']) 
threshold = 0.7
sequence_length = 30

# Store sequences per session
sessions = {}

def extract_keypoints(results):
    """Extract keypoints from MediaPipe results - SAME AS TRAINING"""
    pose = np.array([[res.x, res.y, res.z, res.visibility] 
                     for res in results.pose_landmarks.landmark]).flatten() \
           if results.pose_landmarks else np.zeros(33*4)
    
    face = np.array([[res.x, res.y, res.z] 
                     for res in results.face_landmarks.landmark]).flatten() \
           if results.face_landmarks else np.zeros(468*3)
    
    lh = np.array([[res.x, res.y, res.z] 
                   for res in results.left_hand_landmarks.landmark]).flatten() \
         if results.left_hand_landmarks else np.zeros(21*3)
    
    rh = np.array([[res.x, res.y, res.z] 
                   for res in results.right_hand_landmarks.landmark]).flatten() \
         if results.right_hand_landmarks else np.zeros(21*3)
    
    keypoints = np.concatenate([pose, face, lh, rh])
    
    # Verify shape
    expected_shape = 33*4 + 468*3 + 21*3 + 21*3  # Should be 1662
    if keypoints.shape[0] != expected_shape:
        print(f"⚠️ WARNING: Keypoint shape mismatch! Got {keypoints.shape[0]}, expected {expected_shape}")
    
    return keypoints

def process_frame(image_data, session_id):
    """Process a single frame and return prediction"""
    try:
        # Decode base64 image
        try:
            image_bytes = base64.b64decode(image_data)
            nparr = np.frombuffer(image_bytes, np.uint8)
            frame = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        except Exception as e:
            print(f"❌ Image decode error: {e}")
            return {
                'success': False,
                'error': 'Failed to decode image',
                'message': 'Invalid image data'
            }
        
        if frame is None:
            return {
                'success': False,
                'error': 'Frame is None',
                'message': 'Invalid image data'
            }
        
        # Convert to RGB for MediaPipe
        image_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        image_rgb.flags.writeable = False
        results = holistic.process(image_rgb)
        image_rgb.flags.writeable = True
        
        # Check if hands are visible (critical for sign language)
        hands_visible = (results.left_hand_landmarks is not None or 
                        results.right_hand_landmarks is not None)
        
        if not hands_visible:
            return {
                'success': True,
                'prediction': None,
                'confidence': 0,
                'message': 'No hands detected - show your hands clearly',
                'hands_visible': False,
                'sequence_length': len(sessions.get(session_id, {}).get('sequence', []))
            }
        
        # Extract keypoints
        keypoints = extract_keypoints(results)
        
        # Initialize session if needed
        if session_id not in sessions:
            sessions[session_id] = {
                'sequence': [],
                'predictions': [],
                'last_detection': None,
                'last_prediction': None
            }
            print(f"🆕 New session created: {session_id}")
        
        session = sessions[session_id]
        
        # Add to sequence
        session['sequence'].append(keypoints)
        if len(session['sequence']) > sequence_length:
            session['sequence'].pop(0)
        
        current_length = len(session['sequence'])
        
        # Make prediction only when sequence is full
        if current_length == sequence_length:
            try:
                # Prepare input
                sequence_array = np.expand_dims(session['sequence'], axis=0)
                
                # Make prediction
                res = model.predict(sequence_array, verbose=0)[0]
                predicted_index = np.argmax(res)
                confidence = float(res[predicted_index])
                
                session['predictions'].append(predicted_index)
                
                # Keep only last 10 predictions
                if len(session['predictions']) > 10:
                    session['predictions'].pop(0)
                
                # DEBUG: Print all prediction scores
                all_scores = {actions[i]: float(res[i]) for i in range(len(actions))}
                print(f"🔍 Session {session_id[:8]} - Scores: {all_scores}")
                print(f"🎯 Top: {actions[predicted_index]} ({confidence:.2%})")
                
                # Check for consistent predictions (10 consecutive frames with same prediction)
                if len(session['predictions']) >= 10:
                    recent_preds = session['predictions'][-10:]
                    if all(p == predicted_index for p in recent_preds) and confidence > threshold:
                        detected_action = actions[predicted_index]
                        
                        # Only return if different from last detection (avoid repeats)
                        if session['last_prediction'] != detected_action:
                            session['last_detection'] = time.time()
                            session['last_prediction'] = detected_action
                            
                            print(f"✅ FINAL DETECTION: {detected_action} ({confidence:.2%})")
                            
                            return {
                                'success': True,
                                'prediction': detected_action,
                                'confidence': confidence,
                                'message': 'Sign detected!',
                                'hands_visible': True,
                                'sequence_length': current_length
                            }
                
                return {
                    'success': True,
                    'prediction': None,
                    'confidence': confidence,
                    'message': f'Keep signing... (consistency: {len(session["predictions"])}/10)',
                    'hands_visible': True,
                    'sequence_length': current_length
                }
                
            except Exception as e:
                print(f"❌ Prediction error: {e}")
                traceback.print_exc()
                return {
                    'success': False,
                    'error': str(e),
                    'message': 'Prediction failed'
                }
        else:
            return {
                'success': True,
                'prediction': None,
                'confidence': 0,
                'message': f'Building sequence... ({current_length}/{sequence_length})',
                'hands_visible': True,
                'sequence_length': current_length
            }
        
    except Exception as e:
        print(f"❌ Error processing frame: {e}")
        traceback.print_exc()
        return {
            'success': False,
            'error': str(e),
            'message': f'Error: {str(e)}'
        }

@app.route('/')
def home():
    return jsonify({
        'status': 'running',
        'message': 'Sign Language Detection API',
        'version': '2.1',
        'endpoints': {
            '/predict': 'POST - Send frame for prediction',
            '/reset': 'POST - Reset session',
            '/health': 'GET - Health check',
            '/sessions': 'GET - View active sessions'
        }
    })

@app.route('/health', methods=['GET'])
def health():
    return jsonify({
        'status': 'healthy',
        'model_loaded': model is not None,
        'actions': actions.tolist(),
        'sequence_length': sequence_length,
        'threshold': threshold,
        'active_sessions': len(sessions)
    })

@app.route('/predict', methods=['POST'])
def predict():
    """Main prediction endpoint"""
    try:
        data = request.get_json()
        
        if not data or 'image' not in data:
            return jsonify({
                'success': False,
                'error': 'No image data provided'
            }), 400
        
        image_data = data['image']
        session_id = data.get('session_id', 'default')
        
        result = process_frame(image_data, session_id)
        return jsonify(result)
        
    except Exception as e:
        print(f"❌ API error: {e}")
        traceback.print_exc()
        return jsonify({
            'success': False,
            'error': str(e),
            'message': 'Server error'
        }), 500

@app.route('/reset', methods=['POST'])
def reset_session():
    """Reset a session's sequence"""
    try:
        data = request.get_json()
        session_id = data.get('session_id', 'default')
        
        if session_id in sessions:
            del sessions[session_id]
            print(f"🔄 Session {session_id} deleted")
        
        return jsonify({
            'success': True,
            'message': f'Session {session_id} reset'
        })
        
    except Exception as e:
        print(f"❌ Reset error: {e}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/sessions', methods=['GET'])
def get_sessions():
    """Get active sessions (for debugging)"""
    session_info = {}
    for sid, data in sessions.items():
        session_info[sid] = {
            'sequence_length': len(data['sequence']),
            'predictions_count': len(data['predictions']),
            'last_prediction': data['last_prediction']
        }
    
    return jsonify({
        'active_sessions': list(sessions.keys()),
        'count': len(sessions),
        'details': session_info
    })

# Cleanup old sessions periodically
@app.route('/cleanup', methods=['POST'])
def cleanup_sessions():
    """Remove inactive sessions"""
    try:
        current_time = time.time()
        timeout = 300  # 5 minutes
        
        old_sessions = []
        for sid, data in sessions.items():
            if data['last_detection'] and (current_time - data['last_detection']) > timeout:
                old_sessions.append(sid)
        
        for sid in old_sessions:
            del sessions[sid]
        
        return jsonify({
            'success': True,
            'removed': len(old_sessions),
            'remaining': len(sessions)
        })
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

if __name__ == '__main__':
    print("=" * 60)
    print("🚀 Starting Sign Language Detection API Server")
    print("=" * 60)
    print(f"📊 Loaded actions: {actions}")
    print(f"🎯 Threshold: {threshold}")
    print(f"📏 Sequence length: {sequence_length}")
    print(f"⚠️  Model expects MOTION over {sequence_length} frames")
    print("\n✅ Server is ready!")
    print("=" * 60)
    print("🌐 Local access: http://localhost:5000")
    print("📱 Network access: http://<YOUR_IP>:5000")
    print("=" * 60)
    print("\n💡 Usage Tips:")
    print("   1. Find your IP address:")
    print("      • Windows: Open CMD and type 'ipconfig'")
    print("      • Mac/Linux: Open Terminal and type 'ifconfig'")
    print("      • Look for IPv4 Address (e.g., 192.168.1.15)")
    print("\n   2. Update Flutter app:")
    print("      • Open settings in the app")
    print("      • Enter: http://<YOUR_IP>:5000")
    print("      • Test connection")
    print("\n   3. For best results:")
    print("      • Ensure good lighting")
    print("      • Keep hands visible and centered")
    print("      • Perform sign motion continuously")
    print("      • Hold sign for 2-3 seconds")
    print("=" * 60)
    
    # Run server
    app.run(
        host='0.0.0.0',  # Accessible from network
        port=5000,
        debug=True,
        threaded=True
    )