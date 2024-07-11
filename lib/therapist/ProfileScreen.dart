import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('ملف الأخصائي'),
        backgroundColor: const Color(0xFF528FAA),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            _buildProfileImagePicker(context),
            const SizedBox(height: 20),
            _buildProfileInfo(context, 'الاسم', 'جون'),
            const SizedBox(height: 20),
            _buildProfileInfo(context, 'العمر', '40'),
            const SizedBox(height: 10),
            _buildProfileInfo(context, 'الهوية الخاصة', 'XYZ123'),
            const SizedBox(height: 10),
            _buildProfileInfo(context, 'المستشفى/العيادة', 'مستشفى XYZ'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit profile
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: const Color(0xFF528FAA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'تعديل الملف الشخصي',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('اختر من المعرض'),
                  onTap: () async {
                    // Implement logic to pick image from gallery
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('التقط صورة'),
                  onTap: () async {
                    final cameras = await availableCameras();
                    CameraDescription? camera;
                    if (cameras.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('No Camera Available'),
                            content: Text('Unable to find a camera.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    camera = cameras.firstWhere(
                      (cam) => cam.lensDirection == CameraLensDirection.front,
                      orElse: () => cameras.first,
                    );
                    Navigator.pop(context);
                    final image = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TakePictureScreen(
                          initialCamera: camera!,
                          onPictureTaken: (File picture) {
                            setState(() {
                              _imageFile = picture;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: _imageFile != null
            ? ClipOval(
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(
                Icons.camera_alt,
                size: 60,
                color: Colors.grey,
              ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription initialCamera;
  final Function(File) onPictureTaken;

  const TakePictureScreen({
    Key? key,
    required this.initialCamera,
    required this.onPictureTaken,
  }) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFrontCamera = true;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.initialCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _switchCamera() async {
    final cameras = await availableCameras();
    final newCamera = cameras.firstWhere(
      (cam) => cam.lensDirection != widget.initialCamera.lensDirection,
      orElse: () => widget.initialCamera,
    );
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _controller.dispose();
      _controller = CameraController(
        newCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقاط صورة'),
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ClipRect(
                  child: OverflowBox(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.previewSize!.height,
                        height: _controller.value.previewSize!.width,
                        child: CameraPreview(_controller),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _switchCamera,
              onDoubleTap: _switchCamera,
              behavior: HitTestBehavior.opaque,
              child: Container(), // This is an empty container to capture taps
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    try {
                      await _initializeControllerFuture;
                      final image = await _controller.takePicture();
                      widget.onPictureTaken(image as File); // Pass image back
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Icon(Icons.camera),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
