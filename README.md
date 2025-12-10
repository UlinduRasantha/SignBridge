📘 README.md
# 🧏‍♂️ SignBridge — Real-Time Sri Lankan Sign Language (SLSL) Translator App  

**SignBridge** is an AI-powered two-way translation mobile application enabling hybrid communication between hearing-impaired and hearing individuals.  
It supports **real-time Sign-to-Text** via gesture recognition and **Text-to-Sign** via a 3D animated avatar — providing a seamless and intuitive communication bridge.  

---

## 🧭 Overview

- First-of-its-kind mobile app tailored for Sri Lankan Sign Language (SLSL).  
- Converts live hand gestures into readable text.  
- Converts typed text to animated SLSL gestures through a 3D avatar.  
- Designed for accessibility, independence, and inclusive communication.  

---

## ✨ Key Features

- **Real-time Gesture Recognition** — Uses hand and pose landmark detection for accurate sign classification.  
- **AI-Powered Inference** — Machine learning model (LSTM) to predict sign language gestures reliably.  
- **3D Avatar Rendering** — Animated 3D avatar for clear Text-to-Sign translation.  
- **Cross-Platform Mobile App** — Built with Flutter for wide device compatibility.  
- **Support for Static & Dynamic Signs** — Covers static alphabet gestures and dynamic multi-frame signs.  
- **Extensible Design** — Architecture allows scaling to phrase-level translation, other regional sign languages, and future enhancements.  

---

## 🛠️ Tech Stack

| Layer | Technologies |
|-------|--------------|
| **Mobile App** | Flutter, Dart |
| **Backend / ML Server** | Python, MediaPipe, TensorFlow / LSTM, Flask API |
| **3D Animation & Avatar** | Blender (modeling & rigging), 3D asset export |
| **Data Processing** | NumPy, OpenCV, custom preprocessing pipelines |
| **Communication** | HTTP / WebSocket API for real-time inference & response |

---

## 🏗 System Architecture



[ Smartphone Camera ]
↓ Capture Hand & Pose Data
[ MediaPipe ] → Landmark Extraction
↓
Preprocessing → Normalization
↓
LSTM Model → Gesture Prediction
↓
Flask API → Send Prediction to Mobile Client
↓
Flutter App — Display text or trigger avatar animation
↓
Animated 3D Avatar shows SLSL sign for Text-to-Sign flow


---

## 📁 Project Structure



signbridge/
├── backend/ # ML model, preprocessing, Flask API
│ ├── models/ # Trained LSTM model & checkpoints
│ ├── preprocessing/ # Landmark extraction & data cleaning
│ ├── api.py # REST / WebSocket endpoints
│ └── requirements.txt
│
├── mobile_app/ # Flutter project
│ ├── lib/ # App source code
│ ├── assets/ # Avatar assets, configuration
│ └── pubspec.yaml
│
├── avatar/ # 3D model & animations (Blender files / exports)
│ └── <.blend, .glb, .json animation data>
│
└── README.md # Project documentation (this file)


---

## 🔄 Figma Prototype — UI / UX Design  

<iframe  
  src="https://embed.figma.com/design/7mUHZcsbdboePbW8VL9qIq?embed-host=signbridge"  
  style="border:1px solid rgba(0,0,0,0.1);"  
  width="100%"  
  height="600px"  
  allowfullscreen>  
</iframe>

You can interact with the full prototype and test UI flows directly.  
If embed fails (due to GitHub restrictions), use this link:  
[View the SignBridge Figma Prototype →](https://www.figma.com/design/7mUHZcsbdboePbW8VL9qIq?node-id=0-1)

> ℹ️ Note: For public visibility of embedded prototypes, ensure the Figma file sharing settings are set to “Anyone with link can view.” :contentReference[oaicite:2]{index=2}

---

## 🚀 How to Run / Setup  

### 1. Backend (Gesture Recognition API)  
```bash
cd backend
pip install -r requirements.txt
python api.py         # Starts Flask server for real-time inference

2. Flutter Mobile App
cd mobile_app
flutter pub get
flutter run           # Runs the app on connected device / emulator

3. Avatar Animations

Ensure the 3D model and exported animation assets reside under mobile_app/assets/ (or declared asset path).
No extra build steps required — Flutter will load the animation files as configured.

📸 Screenshots / Demo

(Add your actual app screenshots / demo GIFs below as files in /screenshots and link them accordingly)

Home Screen	Sign-to-Text Camera	Text-to-Sign Avatar

	
	
✅ Achievements & Impact

First SLSL translator app combining real-time recognition + avatar-based reverse translation.

Demonstrated success in departmental demo/testing.

Provides accessible communication tools for hearing-impaired community in Sri Lanka.

🔮 Future Enhancements

Expand gesture vocabulary — support full sentences and conversations.

Integrate phrase-level grammar processing for natural translation.

Optimize model for on-device inference to eliminate network dependency.

Support Sinhala / Tamil / English multilingual UI & translation.

Enhance avatar realism with lip sync / facial expression corresponding to grammar.

👥 Team — Group 36
Name	Role / Contribution
P.B.B. Balasuriya (22UG1-0463)	Dataset & ML model creation, backend integration
U.R. Samarappuli (22UG1-0465)	MediaPipe processing, gesture recording, data preprocessing
U.S. Shashika (22UG1-0495)	Flutter app development, UI/UX, avatar integration, demo prep

Supervisor: Ms. Nilupuli Ekanayake

🪪 License

This project is released under the MIT License.
See the LICENSE file for details.
