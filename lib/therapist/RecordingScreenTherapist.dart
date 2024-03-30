import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class RecordingScreenTherapist extends StatefulWidget {
  const RecordingScreenTherapist({Key? key}) : super(key: key);

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreenTherapist> {
  late CameraController _controller;
  bool _isRecording = false;
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
    await _controller.stopVideoRecording();

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
          title: const Text('حفظ التسجيل'),
          content: const Text('هل تريد حقًا حفظ التسجيل؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('نعم'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('لا'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSaveRecording(BuildContext context) async {
    // Implement logic to save the recording
    print('Recording saved.');
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            ),
          ),
          Visibility(
            visible: _countdown > 0,
            child: Center(
              child: Text(
                _countdown == 0 ? 'بدء التسجيل' : _countdown.toString(),
                style: TextStyle(
                  fontSize: 72,
                  color: _countdown == 0 ? Colors.orange : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: FloatingActionButton(
                backgroundColor: _isRecording ? Colors.red : Colors.blue,
                onPressed: _isRecording ? _stopRecording : _startRecording,
                child:
                    Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
