import 'package:flutter/material.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:video_player/video_player.dart';

class TextToSignTranslate extends StatefulWidget {
  @override
  _TextToSignTranslateState createState() => _TextToSignTranslateState();
}

class _TextToSignTranslateState extends State<TextToSignTranslate> {
  final TextEditingController _textEditingController = TextEditingController();
  VideoPlayerController? _controller;
  ValueNotifier<Duration> _currentPosition = ValueNotifier(Duration.zero);

  List<String> _videoQueue = [];
  List<String> _savedQueue = []; // <-- LAST TRANSLATED SENTENCE STORED HERE
  int _currentIndex = 0;

  final Map<String, String> signMap = {
    'hello': 'assets/video/hello.mp4',
    'හෙලෝ': 'assets/video/hello.mp4',
    'thanks': 'assets/video/thank_you.mp4',
    'ස්තුතියි': 'assets/video/thank_you.mp4',
    'ayubowan': 'assets/video/ayubowan.mp4',
    'ආයුබෝවන්': 'assets/video/ayubowan.mp4',
    'how': 'assets/video/how_are_you.mp4',
    'කොහොමද': 'assets/video/how_are_you.mp4',
    'alright': 'assets/video/alright.mp4',
    'හරි': 'assets/video/alright.mp4',
  };

  @override
  void initState() {
    super.initState();
  }

  // ------------------ MAIN TRANSLATION -------------------
  void _startTranslation() {
    final input = _textEditingController.text.trim().toLowerCase();

    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter text.")),
      );
      return;
    }

    // Clear previous queue & saved sentence
    _videoQueue.clear();
    _savedQueue.clear();

    // PHRASE CHECK FIRST
    if (signMap.containsKey(input)) {
      _videoQueue.add(signMap[input]!);
    } else {
      // WORD BY WORD
      final words = input.split(RegExp(r'\s+'));
      for (var w in words) {
        if (signMap.containsKey(w)) {
          _videoQueue.add(signMap[w]!);
        }
      }
    }

    // Save sentence (overwrite previous)
    _savedQueue = List.from(_videoQueue);

    if (_videoQueue.isNotEmpty) {
      _currentIndex = 0;
      _playCurrentVideo();
    } else {
      _disposeController();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No matching sign videos found.')),
      );
      setState(() {});
    }
  }

  // ------------------ REPLAY LAST SAVED SENTENCE -------------------
  void _replaySavedSentence() {
    if (_savedQueue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No previous sentence saved.')),
      );
      return;
    }

    _videoQueue = List.from(_savedQueue);
    _currentIndex = 0;
    _playCurrentVideo();
  }

  // ------------------ VIDEO PLAYBACK HANDLING -------------------
  void _playCurrentVideo() {
    _disposeController();

    final videoPath = _videoQueue[_currentIndex];
    _controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller?.play();
        _controller?.addListener(_onVideoEnded);
        _controller?.addListener(() {
          _currentPosition.value = _controller!.value.position;
        });
      });
  }

  void _onVideoEnded() {
    if (_controller != null &&
        _controller!.value.position >= _controller!.value.duration &&
        !_controller!.value.isPlaying) {
      _controller?.removeListener(_onVideoEnded);
      _currentIndex++;
      if (_currentIndex < _videoQueue.length) {
        _playCurrentVideo();
      }
    }
  }

  void _disposeController() {
    _controller?.removeListener(_onVideoEnded);
    _controller?.dispose();
    _controller = null;
    _currentPosition.value = Duration.zero;
  }

  @override
  void dispose() {
    _disposeController();
    _currentPosition.dispose();
    super.dispose();
  }

  // ---------------- UI COMPONENTS ----------------
  Widget buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.shade900, width: 1.5),
          ),
          child: TextField(
            controller: _textEditingController,
            maxLines: null,
            expands: true,
            style: TextStyle(color: Colors.blue.shade900),
            decoration: InputDecoration(
              hintText: 'Enter sentence...',
              hintStyle: TextStyle(color: Colors.blue.shade300),
              filled: true,
              fillColor: Colors.blue[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // TRANSLATE BUTTON
        Center(
          child: ElevatedButton.icon(
            onPressed: _startTranslation,
            icon: Icon(Icons.translate),
            label: Text("Translate to Sign"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),

        // REPLAY BUTTON (Option A)
        Center(
          child: ElevatedButton.icon(
            onPressed: _replaySavedSentence,
            icon: Icon(Icons.replay),
            label: Text("Replay Last Sentence"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Text to Sign Translate', style: appbartitlestyle),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInputSection(),
                SizedBox(height: 20),

                // ---------------- VIDEO DISPLAY ----------------
                Center(
                  child: Container(
                    width: 320,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue.shade900,
                        width: 1.8,
                      ),
                    ),
                    child:
                        _controller != null && _controller!.value.isInitialized
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox.expand(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                      width: _controller!.value.size.width,
                                      height: _controller!.value.size.height,
                                      child: VideoPlayer(_controller!),
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/avata.jpeg',
                                  width: 320,
                                  height: 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ),
                ),

                SizedBox(height: 30),

                // ---------------- SLIDER ----------------
                ValueListenableBuilder<Duration>(
                  valueListenable: _currentPosition,
                  builder: (context, position, child) {
                    final duration =
                        _controller?.value.duration ?? Duration.zero;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${formatDuration(position)}',
                                  style: TextStyle(color: Colors.blue)),
                              Text('${formatDuration(duration)}',
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                        Slider(
                          value: position.inSeconds
                              .toDouble()
                              .clamp(0, duration.inSeconds.toDouble()),
                          min: 0.0,
                          max: duration.inSeconds.toDouble(),
                          activeColor: Colors.blue.shade900,
                          inactiveColor: Colors.blue.shade100,
                          onChanged: (double value) {
                            _controller
                                ?.seekTo(Duration(seconds: value.toInt()));
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Format timer mm:ss
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
