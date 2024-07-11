import 'package:flutter/material.dart';

class ShowRecording extends StatefulWidget {
  const ShowRecording({Key? key}) : super(key: key);

  @override
  _ShowRecordingState createState() => _ShowRecordingState();
}

class _ShowRecordingState extends State<ShowRecording> {
  // Mock data for recordings
  final List<String> recordings = [
    'التسجيل 1',
    'التسجيل 2',
    'التسجيل 3',
    'التسجيل 4',
    'التسجيل 5',
    'التسجيل 6',
    // Add more recordings as needed
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة التسجيلات'),
      ),
      body: GridView.builder(
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
              // Add functionality to play the recording
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
                    offset: const Offset(0, 3), // changes position of shadow
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
                    recordings[index],
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
