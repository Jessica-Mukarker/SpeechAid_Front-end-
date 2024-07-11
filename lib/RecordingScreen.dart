import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:speech_aid/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class RecordingScreen extends StatefulWidget {
  final String therapist_id;
  final String patient_id;
  final String exercise_id;
  final String exerciseUrl;

  const RecordingScreen({
    Key? key,
    required this.patient_id,
    required this.therapist_id,
    required this.exercise_id,
    required this.exerciseUrl,
  }) : super(key: key);

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  late CameraController _controller;
  late bool _isRecording;
  late bool _isCameraMode;
  late int _countdown;
  Timer? _timer;
  bool intilizedvideo = false;
  late VideoPlayerController _controllerVideo;
  late Future<void> _initializeVideoPlayerFuture;
  Future<void> _initializeVideoPlayer() async {
    final uri = Uri.parse(widget.exerciseUrl);
    print(uri);

    if (widget.exerciseUrl.startsWith("http")) {
      final response = await http.get(uri);
      final bytes = response.bodyBytes;

      // Write bytes to a temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/video_temp.mp4');
      await tempFile.writeAsBytes(bytes);

      _controllerVideo = VideoPlayerController.file(tempFile);
    } else {
      _controllerVideo = VideoPlayerController.networkUrl(uri,
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: false,
            mixWithOthers: false,
          ));
    }

    _initializeVideoPlayerFuture = _controllerVideo.initialize();
    _initializeVideoPlayerFuture.then((_) {
      setState(() {
        intilizedvideo = true;
      });
      _controllerVideo.play();
      _controllerVideo.setLooping(true);
    });
  }

  @override
  void initState() {
    super.initState();

    _initializeVideoPlayer();

    // _controllerVideo.setLooping(true);
    _isRecording = false;
    _isCameraMode = true;
    _countdown = 0;
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    CameraDescription? selectedCamera;

    // Try initializing with the front camera
    for (final camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        selectedCamera = camera;
        break;
      }
    }

    // If front camera not available, use the back camera
    if (selectedCamera == null && cameras.isNotEmpty) {
      selectedCamera = cameras.first;
    }

    // If a camera is found, initialize the controller
    if (selectedCamera != null) {
      _controller = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
      );

      await _controller.initialize();
      if (!mounted) return;
      setState(() {});
    } else {
      // Handle case when no camera is available
      print('No camera available');
    }
  }

  void _startRecording() {
    print('Starting recording...');
    _startCountdown();
    setState(() {
      _isRecording = true;
    });
  }

  void _startCountdown() {
    print('Countdown started.');
    const oneSec = Duration(seconds: 1);
    setState(() {
      _countdown = 3;
    });

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 0) {
          timer.cancel();
          _startRecordingProcess();
        } else {
          setState(() {
            _countdown--;
            print('Countdown: $_countdown');
          });
        }
      },
    );
  }

  void _startRecordingProcess() async {
    await _controller.startVideoRecording();
  }

  void _stopRecording() async {
    print('Stopping recording...');
    setState(() {
      _isRecording = false;
      _countdown = 0;
    });
    _timer?.cancel();
    XFile videoFile = await _controller.stopVideoRecording();

    bool? shouldSave = await _showSaveConfirmationDialog(context);
    if (shouldSave ?? false) {
      _handleSaveRecording(context, videoFile.path);
    }
  }

  Future<bool?> _showSaveConfirmationDialog(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Recording'),
          content: const Text(
              'Do you want to save the recording and send it to the therapist?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSaveRecording(BuildContext context, String path) async {
    String apiUrl = RECORDING;

    Map<String, String> headers = {"Content-type": "application/json"};

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files
        .add(await http.MultipartFile.fromPath('recording_file', path));
    request.fields['therapist_id'] = widget.therapist_id;
    request.fields['patient_id'] = widget.patient_id;
    request.fields['exercise_id'] = widget.exercise_id;
    request.fields['is_patient_url'] = "1";
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Video uploaded successfully');
    } else {
      print('Failed to upload video. Error: ${response.statusCode}');
    }
  }

  void _toggleCameraMode() {
    setState(() {
      _isCameraMode = !_isCameraMode;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _controllerVideo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة التسجيل'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.help_outline,
            ),
            onPressed: () {
              _showMenu(context); // Pass the BuildContext as an argument
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _toggleCameraMode,
        child: _isCameraMode ? _buildCameraSection() : _buildVideoSection(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              color: Colors.transparent, // Placeholder color
              child: Center(
                child: constraints.maxWidth < 600
                    ? Center(
                        child: FloatingActionButton(
                          backgroundColor: _isRecording
                              ? Colors.red
                              : const Color(0xFF528FAA),
                          onPressed:
                              _isRecording ? _stopRecording : _startRecording,
                          child: Icon(_isRecording
                              ? Icons.stop
                              : Icons.fiber_manual_record),
                        ),
                      )
                    : FloatingActionButton(
                        backgroundColor:
                            _isRecording ? Colors.red : const Color(0xFF528FAA),
                        onPressed:
                            _isRecording ? _stopRecording : _startRecording,
                        child: Icon(_isRecording
                            ? Icons.stop
                            : Icons.fiber_manual_record),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCameraSection() {
    return _controller.value.isInitialized
        ? LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > constraints.maxHeight) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        child: _buildCameraWidgetWithCountdown(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: CameraPreview(_controller),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        child: _buildCameraWidgetWithCountdown(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: CameraPreview(_controller),
                      ),
                    ),
                  ],
                );
              }
            },
          )
        : Container();
  }

  Widget _buildCameraWidgetWithCountdown() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: _countdown > 0,
          child: Text(
            _countdown == 0 ? 'Start Recording' : _countdown.toString(),
            style: TextStyle(
              fontSize: 72,
              color: _countdown == 0 ? Colors.orange : const Color(0xFF52A0AA),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            intilizedvideo
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(
                          _controllerVideo,
                        ),
                        VideoProgressIndicator(_controllerVideo,
                            allowScrubbing: true),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                !_controllerVideo.value.isPlaying
                                    ? Icons.play_arrow
                                    : Icons.pause,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_controllerVideo.value.isPlaying) {
                                    _controllerVideo.pause();
                                  } else {
                                    _controllerVideo.play();
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.replay,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controllerVideo.seekTo(Duration.zero);
                                  _controllerVideo.play();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
            Visibility(
              visible: _countdown > 0,
              child: Text(
                _countdown == 0 ? 'Start Recording' : _countdown.toString(),
                style: TextStyle(
                  fontSize: 72,
                  color:
                      _countdown == 0 ? Colors.orange : const Color(0xFF52A0AA),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: CameraPreview(_controller),
          ),
        ),
      ],
    );
  }

  void _showMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'مساعدة',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'السَّين هو حرف من حروف الهجاء العربية، وهو مُهمل إذا وقع في منتصف الكلمة، وينطق كلما وُضع في بدايتها وفي نهايتها، وهو متميز بصوته المهموس.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/sLetter1.jpg',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 8),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Handle close action
                          },
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Image.asset(
                          'assets/sLetter2.jpg',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 8),
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            // Handle check action
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }
}
