import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_aid/Constants.dart';
import 'package:speech_aid/VideoPage.dart';
import 'package:video_player/video_player.dart';

class ShowRecording extends StatefulWidget {
  final String therapist_id;
  final String patient_id;
  final String recrding_id;
  final String recordingUrl;

  const ShowRecording({
    Key? key,
    required this.patient_id,
    required this.therapist_id,
    required this.recrding_id,
    required this.recordingUrl,
  }) : super(key: key);

  @override
  _ShowRecordingState createState() => _ShowRecordingState();
}

class _ShowRecordingState extends State<ShowRecording> {
  List<dynamic> recordings = [];
  bool isLoading = true;
  String patientId = "0";

  @override
  void initState() {
    super.initState();
    fetchRecordings();
    _initializeVideoPlayer();
  }

  Future<void> fetchRecordings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    patientId = prefs.getString("patient_id") ?? "0";
    print("patientid: $patientId");

    final response =
        await http.get(Uri.parse('$RECORDING?patientid=$patientId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        recordings = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load recordings');
    }
  }

  bool intilizedvideo = false;
  late VideoPlayerController _controllerVideo;
  late Future<void> _initializeVideoPlayerFuture;

  Future<void> _initializeVideoPlayer() async {
    final uri = Uri.parse(widget.recordingUrl);
    print(uri);

    if (widget.recordingUrl.startsWith("http")) {
      final response = await http.get(uri);
      final bytes = response.bodyBytes;

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/video_temp.mp4');
      await tempFile.writeAsBytes(bytes);

      _controllerVideo = VideoPlayerController.file(tempFile);
    } else {
      _controllerVideo = VideoPlayerController.network(uri.toString());
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
  void dispose() {
    _controllerVideo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة التسجيلات'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: recordings.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 800 ? 2 : 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPage(
                          exerciseUrl:
                              baseurl + recordings[index]['recording_url'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_circle_filled,
                            size: 48.0, color: Colors.blue),
                        const SizedBox(height: 8.0),
                        Text(
                          recordings[index]['recording_date'].toString(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
