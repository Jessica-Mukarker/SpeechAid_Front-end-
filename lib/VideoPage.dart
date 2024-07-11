import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class VideoPage extends StatefulWidget {
  final String exerciseUrl;

  const VideoPage({
    Key? key,
    required this.exerciseUrl,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controllerVideo;
  late Future<void> _initializeVideoPlayerFuture;
  bool loading = true;

  @override
  void initState() {
    _initializeVideoPlayer();
    super.initState();
  }

  Future<void> _initializeVideoPlayer() async {
    final uri = Uri.parse(widget.exerciseUrl);
    if (!widget.exerciseUrl.startsWith("https")) {
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
        loading = false;
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
        title: const Text('Video Page'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AspectRatio(
                  aspectRatio: _controllerVideo.value.aspectRatio,
                  child: VideoPlayer(_controllerVideo),
                ),
                VideoProgressIndicator(
                  _controllerVideo,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    backgroundColor: Colors.grey,
                    playedColor: Colors.blue,
                    bufferedColor: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controllerVideo.value.isPlaying) {
              _controllerVideo.pause();
            } else {
              _controllerVideo.play();
            }
          });
        },
        child: Icon(
          _controllerVideo.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
