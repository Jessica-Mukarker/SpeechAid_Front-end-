import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recording App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecordingScreen(),
    );
  }
}

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({Key? key}) : super(key: key);

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  CameraController? _controller;
  bool _isRecording = false;
  bool _isCameraMode = true;
  int _countdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
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

      await _controller!.initialize();
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
    await _controller!.startVideoRecording();
  }

  void _stopRecording() async {
    print('Stopping recording...');
    setState(() {
      _isRecording = false;
      _countdown = 0;
    });
    _timer?.cancel();
    await _controller!.stopVideoRecording();

    bool? shouldSave = await _showSaveConfirmationDialog(context);
    if (shouldSave ?? false) {
      _handleSaveRecording(context);
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

  Future<void> _handleSaveRecording(BuildContext context) async {
    _uploadAndSaveRecording();
  }

  void _uploadAndSaveRecording() async {
    // Implement logic to upload recording to Firebase Storage and Google Drive
    // Upload recording to Firebase Storage
    String firebaseStorageUrl = await _uploadToFirebaseStorage();

    // Upload recording to Google Drive
    String googleDriveUrl = await _uploadToGoogleDrive();

    // Save URLs in Firebase Database
    _saveRecordingUrls(firebaseStorageUrl, googleDriveUrl);

    // Show success message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Recording saved and sent to the therapist successfully.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<String> _uploadToFirebaseStorage() async {
    // Implement logic to upload recording to Firebase Storage
    // Return the URL of the uploaded recording
    return ''; // Placeholder URL
  }

  Future<String> _uploadToGoogleDrive() async {
    // Implement logic to upload recording to Google Drive
    // Return the URL of the uploaded recording
    return ''; // Placeholder URL
  }

  void _saveRecordingUrls(String firebaseUrl, String driveUrl) {
    // Implement logic to save URLs in Firebase Database
  }

  void _toggleCameraMode() {
    setState(() {
      _isCameraMode = !_isCameraMode;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller!.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة التسجيل'),
        actions: [
          Visibility(
            visible: _isRecording,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: const Text(
                'تسجيل',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
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
    return _controller != null && _controller!.value.isInitialized
        ? LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > constraints.maxHeight) {
                // Landscape mode
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey, // Placeholder color
                        child: _buildCameraWidgetWithCountdown(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: CameraPreview(_controller!),
                      ),
                    ),
                  ],
                );
              } else {
                // Portrait mode
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey, // Placeholder color
                        child: _buildCameraWidgetWithCountdown(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: CameraPreview(_controller!),
                      ),
                    ),
                  ],
                );
              }
            },
          )
        : Container(); // Return an empty container if controller is null or not initialized
  }

  Widget _buildCameraWidgetWithCountdown() {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Center(
          child: Text(
            'Your video widget here',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > constraints.maxHeight) {
          // Landscape mode
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.grey, // Placeholder color
                      child: const Center(
                        child: Text(
                          'Your video widget here',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _countdown > 0,
                      child: Text(
                        _countdown == 0
                            ? 'Start Recording'
                            : _countdown.toString(),
                        style: TextStyle(
                          fontSize: 72,
                          color: _countdown == 0
                              ? Colors.orange
                              : const Color(0xFF52A0AA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: CameraPreview(_controller!),
                ),
              ),
            ],
          );
        } else {
          // Portrait mode
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.grey, // Placeholder color
                      child: const Center(
                        child: Text(
                          'Your video widget here',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _countdown > 0,
                      child: Text(
                        _countdown == 0
                            ? 'Start Recording'
                            : _countdown.toString(),
                        style: TextStyle(
                          fontSize: 72,
                          color: _countdown == 0
                              ? Colors.orange
                              : const Color(0xFF52A0AA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: CameraPreview(_controller!),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}