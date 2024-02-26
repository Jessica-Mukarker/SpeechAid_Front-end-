import 'package:flutter/material.dart';
import 'RecordingScreen.dart'; // Import the RecordingScreen page

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Dashboard!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecordingScreen()),
                );
              },
              child: const Text('Go to Recording Screen'), // Text on the button
            ),
          ],
        ),
      ),
    );
  }
}
