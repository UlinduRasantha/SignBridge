import 'package:flutter/material.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;

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
  bool isProcessing = false;
  bool isTranslating = false;
  bool isStoppingStream = false; // NEW: Flag to prevent race conditions
  int currentCameraIndex = 0;

  // Detection results
  String detectedText = 'Text';
  double confidence = 0.0;
  int sequenceLength = 0;
  bool handsVisible = false;
  String statusMessage = '';

  // API configuration
  String apiUrl = 'http://192.168.8.106:5000';
  String sessionId = const Uuid().v4();

  // Frame rate control
  DateTime? lastFrameTime;
  final Duration frameDuration = const Duration(milliseconds: 100);

  // Stream subscription for better control
  StreamSubscription? _imageStreamSubscription;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        if (currentCameraIndex >= cameras!.length) currentCameraIndex = 0;

        await _cameraController?.dispose();

        _cameraController = CameraController(
          cameras![currentCameraIndex],
          ResolutionPreset.medium,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.yuv420,
        );

        await _cameraController!.initialize();

        if (mounted) {
          setState(() {
            isCameraInitialized = true;
          });
          print(
              '✅ Camera initialized: ${cameras![currentCameraIndex].lensDirection}');
        }
      }
    } catch (e) {
      print('❌ Camera init error: $e');
      if (mounted) {
        _showSnack('Camera initialization failed: $e', true);
      }
    }
  }

  void _toggleCamera() {
    if (isCameraOn) {
      // First stop translation if running
      if (isTranslating) {
        _stopTranslation();
      }

      setState(() {
        isCameraOn = false;
        detectedText = 'Text';
        sequenceLength = 0;
        statusMessage = '';
      });
      print('📷 Camera turned OFF');
    } else {
      setState(() {
        isCameraOn = true;
      });
      print('📷 Camera turned ON');
    }
  }

  Future<void> _switchCamera() async {
    if (cameras == null || cameras!.length < 2) {
      _showSnack('No other camera available', true);
      return;
    }

    if (isTranslating) {
      await _stopTranslation();
    }

    await _cameraController?.dispose();
    setState(() {
      isCameraInitialized = false;
    });

    currentCameraIndex = (currentCameraIndex + 1) % cameras!.length;
    await _initializeCamera();

    if (mounted) {
      final cameraType = cameras![currentCameraIndex].lensDirection ==
              CameraLensDirection.front
          ? "front"
          : "back";
      _showSnack('Switched to $cameraType camera', false);
    }
  }

  Future<void> _toggleTranslation() async {
    if (!isCameraOn || !isCameraInitialized) {
      _showSnack('Please turn on the camera first', true);
      return;
    }

    if (isTranslating) {
      await _stopTranslation();
    } else {
      await _startTranslation();
    }
  }

  Future<void> _startTranslation() async {
    print('🟢 Starting translation...');

    setState(() {
      isTranslating = true;
      sessionId = const Uuid().v4();
      statusMessage = 'Starting...';
      detectedText = 'Text';
      sequenceLength = 0;
      isProcessing = false;
      isStoppingStream = false;
    });

    // Small delay to ensure state is set
    await Future.delayed(const Duration(milliseconds: 100));

    _startProcessing();
  }

  Future<void> _stopTranslation() async {
    print('🔴 Stopping translation...');

    // Set flags immediately
    setState(() {
      isStoppingStream = true;
      statusMessage = 'Stopping...';
    });

    try {
      // Stop the image stream first
      if (_cameraController != null &&
          _cameraController!.value.isStreamingImages) {
        await _cameraController!.stopImageStream();
        print('✅ Image stream stopped');
      }
    } catch (e) {
      print('⚠️ Error stopping stream: $e');
    }

    // Reset session on server
    await _resetSession();

    // Small delay to ensure all frames are processed
    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      setState(() {
        isTranslating = false;
        isProcessing = false;
        isStoppingStream = false;
        detectedText = 'Text';
        sequenceLength = 0;
        statusMessage = '';
        lastFrameTime = null;
      });
      print('✅ Translation stopped completely');
    }
  }

  void _startProcessing() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      _showSnack('Camera not ready', true);
      setState(() {
        isTranslating = false;
      });
      return;
    }

    if (_cameraController!.value.isStreamingImages) {
      print('⚠️ Stream already active');
      return;
    }

    try {
      print('📹 Starting image stream...');

      _cameraController!.startImageStream((CameraImage image) async {
        // Early exit checks
        if (isStoppingStream || !isTranslating || !mounted) {
          return;
        }

        // Frame rate limiting
        final now = DateTime.now();
        if (lastFrameTime != null &&
            now.difference(lastFrameTime!) < frameDuration) {
          return;
        }

        // Processing lock
        if (isProcessing) {
          return;
        }

        lastFrameTime = now;
        isProcessing = true;

        try {
          final base64Image = await _convertImageToBase64(image);

          // Check again before sending (might have stopped during conversion)
          if (!isTranslating || isStoppingStream || !mounted) {
            isProcessing = false;
            return;
          }

          final result = await _sendFrameToApi(base64Image);

          if (mounted &&
              result != null &&
              result['success'] == true &&
              isTranslating) {
            setState(() {
              if (result['prediction'] != null && result['prediction'] != '') {
                detectedText = result['prediction'].toString().toUpperCase();
                confidence = (result['confidence'] ?? 0.0).toDouble();
              }
              sequenceLength = result['sequence_length'] ?? 0;
              handsVisible = result['hands_visible'] ?? false;
              statusMessage = result['message'] ?? '';
            });
          }
        } catch (e) {
          print('⚠️ Processing error: $e');
        } finally {
          isProcessing = false;
        }
      });

      print('✅ Image stream started');
    } catch (e) {
      print('❌ Failed to start stream: $e');
      _showSnack('Failed to start camera stream: $e', true);
      if (mounted) {
        setState(() {
          isTranslating = false;
        });
      }
    }
  }

  Future<String> _convertImageToBase64(CameraImage cameraImage) async {
    try {
      final int width = cameraImage.width;
      final int height = cameraImage.height;

      img.Image image = img.Image(width: width, height: height);

      final yPlane = cameraImage.planes[0];
      final uPlane = cameraImage.planes[1];
      final vPlane = cameraImage.planes[2];

      final int uvRowStride = uPlane.bytesPerRow;
      final int uvPixelStride = uPlane.bytesPerPixel ?? 1;

      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          final int uvIndex =
              uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
          final int index = h * yPlane.bytesPerRow + w;

          final yValue = yPlane.bytes[index];
          final uValue = uPlane.bytes[uvIndex];
          final vValue = vPlane.bytes[uvIndex];

          int r = (yValue + vValue * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yValue -
                  uValue * 46549 / 131072 +
                  44 -
                  vValue * 93604 / 131072 +
                  91)
              .round()
              .clamp(0, 255);
          int b = (yValue + uValue * 1814 / 1024 - 227).round().clamp(0, 255);

          image.setPixelRgb(w, h, r, g, b);
        }
      }

      final resized = img.copyResize(image, width: 640);
      final jpegBytes = img.encodeJpg(resized, quality: 85);

      return base64Encode(jpegBytes);
    } catch (e) {
      print('❌ Image conversion error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> _sendFrameToApi(String base64Image) async {
    try {
      final response = await http
          .post(
            Uri.parse('$apiUrl/predict'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'image': base64Image,
              'session_id': sessionId,
            }),
          )
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('❌ API error: ${response.statusCode}');
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } on TimeoutException {
      print('⏱️ Connection timeout');
      return {'success': false, 'message': 'Connection timeout'};
    } on http.ClientException catch (e) {
      print('❌ Network error: $e');
      if (mounted && isTranslating) {
        _showSnack('Cannot connect to server. Check IP address.', true);
      }
      return {'success': false, 'message': 'Cannot connect to server'};
    } catch (e) {
      print('❌ Unexpected error: $e');
      return {'success': false, 'message': 'Network error'};
    }
  }

  Future<void> _resetSession() async {
    try {
      await http
          .post(
            Uri.parse('$apiUrl/reset'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'session_id': sessionId}),
          )
          .timeout(const Duration(seconds: 2));
      print('🔄 Session reset');
    } catch (e) {
      print('⚠️ Reset error (non-critical): $e');
    }
  }

  Future<void> _testConnection() async {
    _showSnack('Testing connection...', false);

    try {
      final response = await http
          .get(Uri.parse('$apiUrl/health'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _showSnack('✅ Connected! Actions: ${data['actions']}', false);
        print('✅ Server health check passed');
        print('📊 Available actions: ${data['actions']}');
      } else {
        _showSnack('Server error: ${response.statusCode}', true);
      }
    } on TimeoutException {
      _showSnack('❌ Connection timeout. Check if server is running.', true);
    } on http.ClientException {
      _showSnack('❌ Cannot reach server. Check IP address: $apiUrl', true);
    } catch (e) {
      _showSnack('❌ Connection failed: $e', true);
      print('❌ Connection test failed: $e');
    }
  }

  void _showSettingsDialog() {
    final controller = TextEditingController(text: apiUrl);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Server Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Server URL',
                hintText: 'http://192.168.8.106:5000',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'How to find your IP:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              '• Windows: ipconfig in cmd\n'
              '• Mac/Linux: ifconfig in terminal\n'
              '• Look for IPv4 address',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                apiUrl = controller.text.trim();
                if (!apiUrl.startsWith('http')) {
                  apiUrl = 'http://$apiUrl';
                }
                if (!apiUrl.contains(':')) {
                  apiUrl = '$apiUrl:5000';
                }
              });
              Navigator.pop(context);
              _testConnection();
            },
            child: const Text('Save & Test'),
          ),
        ],
      ),
    );
  }

  void _showSnack(String message, bool isError) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  @override
  void dispose() {
    isStoppingStream = true;
    isTranslating = false;

    try {
      _cameraController?.stopImageStream();
    } catch (e) {
      print('Error stopping stream in dispose: $e');
    }

    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final previewWidth = screenWidth * 0.9;
    final previewHeight = previewWidth * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign To Text Translate', style: appbartitlestyle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: isTranslating ? null : _showSettingsDialog,
            tooltip: 'Server Settings',
          ),
          IconButton(
            icon: const Icon(Icons.wifi),
            onPressed: isTranslating ? null : _testConnection,
            tooltip: 'Test Connection',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),

              // Status indicator
              if (isTranslating)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Detecting... ($sequenceLength/30)',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (handsVisible) ...[
                        const SizedBox(width: 8),
                        Icon(Icons.back_hand,
                            size: 16, color: Colors.green.shade700),
                      ],
                    ],
                  ),
                ),

              // Camera preview
              Center(
                child: Container(
                  width: previewWidth,
                  height: previewHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isTranslating ? Colors.green : boxborder,
                      width: isTranslating ? 2.5 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      if (isCameraOn && isCameraInitialized)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: CameraPreview(_cameraController!),
                          ),
                        )
                      else if (isCameraOn && !isCameraInitialized)
                        const Center(child: CircularProgressIndicator())
                      else
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.videocam_off,
                                  size: 60, color: Colors.grey),
                              SizedBox(height: 10),
                              Text('Camera is off',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),

                      // Flip camera button
                      if (isCameraOn &&
                          isCameraInitialized &&
                          cameras != null &&
                          cameras!.length > 1)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.flip_camera_ios,
                                  size: 24, color: Colors.white),
                              onPressed: isTranslating ? null : _switchCamera,
                              tooltip: 'Switch Camera',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 56,
                    width: 160,
                    child: customButton(
                      icon: isTranslating ? Icons.stop : Icons.gesture,
                      label: isTranslating ? 'Stop' : 'Start Translation',
                      bgColor: isTranslating
                          ? Colors.red.shade50
                          : Colors.blue.shade50,
                      labelStyle: TextStyle(
                        color: isTranslating
                            ? Colors.red.shade700
                            : const Color(0xFF0D47A1),
                        fontWeight: FontWeight.bold,
                      ),
                      border: BorderSide(
                        color: isTranslating
                            ? Colors.red.shade700
                            : const Color(0xFF0D47A1),
                        width: 1.5,
                      ),
                      onPressed: isCameraOn ? _toggleTranslation : null,
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    width: 140,
                    child: customButton(
                      icon: Icons.camera_alt,
                      label: isCameraOn ? 'Turn Off' : 'Camera',
                      bgColor: Colors.blue.shade50,
                      labelStyle: const TextStyle(
                        color: Color(0xFF0D47A1),
                        fontWeight: FontWeight.bold,
                      ),
                      border:
                          BorderSide(color: Colors.blue.shade900, width: 1.5),
                      onPressed: _toggleCamera,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Detected text display
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 600),
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: boxfilcolor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: boxborder, width: 1.6),
                      ),
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            detectedText,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              color: detectedText == 'Text'
                                  ? texticonColor
                                  : const Color(0xFF0D47A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (confidence > 0) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${(confidence * 100).toStringAsFixed(0)}% confident',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.download, color: texticonColor),
                            onPressed: detectedText != 'Text'
                                ? () =>
                                    _showSnack('Download coming soon!', false)
                                : null,
                          ),
                          IconButton(
                            icon: Icon(Icons.share, color: texticonColor),
                            onPressed: detectedText != 'Text'
                                ? () => _showSnack('Share coming soon!', false)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Status message
              if (statusMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    statusMessage,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusMessage.contains('Error') ||
                              statusMessage.contains('timeout')
                          ? Colors.red
                          : Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customButton({
  required IconData icon,
  required String label,
  required Color bgColor,
  TextStyle? labelStyle,
  VoidCallback? onPressed,
  BorderSide? border,
}) {
  final isDisabled = onPressed == null;

  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(
      icon,
      color: isDisabled
          ? Colors.grey.shade400
          : (labelStyle?.color ?? Colors.blue),
    ),
    label: Text(
      label,
      style: isDisabled
          ? TextStyle(color: Colors.grey.shade400)
          : (labelStyle ?? const TextStyle(color: Colors.blue)),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: isDisabled ? Colors.grey.shade200 : bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isDisabled
            ? BorderSide(color: Colors.grey.shade400)
            : (border ?? const BorderSide(color: Colors.blue)),
      ),
    ),
  );
}
