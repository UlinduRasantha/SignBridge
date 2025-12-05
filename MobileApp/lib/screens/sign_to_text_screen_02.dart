import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/style.dart';

class SignToTextScreen02 extends StatefulWidget {
  const SignToTextScreen02({super.key});

  @override
  _SignToTextScreen02State createState() => _SignToTextScreen02State();
}

class _SignToTextScreen02State extends State<SignToTextScreen02> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  bool isCameraOn = false;
  bool _isTranslating = false;
  int _selectedCameraIndex = 1; // 1 = front camera usually

  Timer? _captureTimer;
  String translatedText = "Text";
  double confidence = 0.0;

  // ⚠️ Change to your Flask server IP and port
  final String apiUrl = "http://192.168.1.10:5000/predict";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera([int cameraIndex = 1]) async {
    try {
      cameras = await availableCameras();
      if (cameras!.isNotEmpty && cameraIndex < cameras!.length) {
        _cameraController = CameraController(
          cameras![cameraIndex],
          ResolutionPreset.medium,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        setState(() {
          isCameraInitialized = true;
          isCameraOn = true;
          _selectedCameraIndex = cameraIndex;
        });
      }
    } catch (e) {
      debugPrint('Camera init error: $e');
    }
  }

  /// Start sending frames periodically to Flask
  void _startTranslation() {
    if (_isTranslating || !isCameraInitialized) return;

    _isTranslating = true;
    translatedText = "Detecting...";
    confidence = 0.0;

    _captureTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      await _captureAndSendFrame();
    });

    setState(() {});
  }

  /// Stop frame sending
  void _stopTranslation() {
    _captureTimer?.cancel();
    _isTranslating = false;
    setState(() {});
  }

  /// Capture frame and send to Flask
  Future<void> _captureAndSendFrame() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      final XFile image = await _cameraController!.takePicture();
      final bytes = await File(image.path).readAsBytes();

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..files.add(await http.MultipartFile.fromBytes('frame', bytes,
            filename: 'frame.jpg'));

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final result = jsonDecode(respStr);

        setState(() {
          translatedText = result['prediction'] ?? "Unknown";
          confidence = (result['confidence'] ?? 0.0) * 100;
        });
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Frame send error: $e");
    }
  }

  void _switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;
    final newIndex = (_selectedCameraIndex + 1) % cameras!.length;
    await _cameraController?.dispose();
    await _initializeCamera(newIndex);
  }

  void _toggleCamera() async {
    if (isCameraOn) {
      await _cameraController?.dispose();
      setState(() {
        isCameraOn = false;
        isCameraInitialized = false;
      });
    } else {
      await _initializeCamera(_selectedCameraIndex);
    }
  }

  @override
  void dispose() {
    _captureTimer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Sign To Text Translate', style: appbartitlestyle)),
      body: Column(
        children: [
          const SizedBox(height: 40),

          // 🎥 Camera preview
          Center(
            child: Container(
              width: 320,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: boxborder, width: 1.8),
              ),
              child: isCameraInitialized
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CameraPreview(_cameraController!),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),

          const SizedBox(height: 30),

          // 🧭 Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customButton(
                icon: Icons.gesture,
                label:
                    _isTranslating ? 'Stop Translation' : 'Start Translation',
                bgColor: Colors.blue.shade50,
                labelStyle: const TextStyle(color: Color(0xFF0D47A1)),
                onPressed:
                    _isTranslating ? _stopTranslation : _startTranslation,
              ),
              const SizedBox(width: 10),
              customButton(
                icon: Icons.cameraswitch_rounded,
                label: 'Switch',
                bgColor: Colors.blue.shade50,
                labelStyle: const TextStyle(color: Color(0xFF0D47A1)),
                onPressed: _switchCamera,
              ),
              const SizedBox(width: 10),
              customButton(
                icon: Icons.camera_alt,
                label: isCameraOn ? 'Turn Off' : 'Camera',
                bgColor: Colors.blue.shade50,
                labelStyle: const TextStyle(color: Color(0xFF0D47A1)),
                onPressed: _toggleCamera,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // 📝 Output
          Container(
            width: 320,
            height: 100,
            decoration: BoxDecoration(
              color: boxfilcolor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: boxborder, width: 1.8),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translatedText,
                  style:
                      GoogleFonts.poppins(fontSize: 18, color: texticonColor),
                ),
                const SizedBox(height: 4),
                Text(
                  "Confidence: ${confidence.toStringAsFixed(1)}%",
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom button widget
Widget customButton({
  required IconData icon,
  required String label,
  required Color bgColor,
  TextStyle? labelStyle,
  VoidCallback? onPressed,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, color: labelStyle?.color ?? Colors.blue),
    label:
        Text(label, style: labelStyle ?? const TextStyle(color: Colors.blue)),
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
