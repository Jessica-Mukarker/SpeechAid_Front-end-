import 'package:flutter/material.dart';
import 'package:speech_aid/therapist/CustomAppBarTherapist.dart';
import 'package:speech_aid/therapist/VideosPage.dart';

class ExerciseTherapist extends StatelessWidget {
  const ExerciseTherapist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTherapist(
        title: const Text('الصفحة التمرينات'),
        notificationCount: 0, // Set notificationCount to 0 initially
        onMenuItemSelected: (String value) {
          // Handle menu item selection here
        },
      ),
      body: Column(
        children: [
          // Image added here
          Image.asset(
            'assets/image.png',
            width: 150,
            height: 150,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding:
                  const EdgeInsets.all(30), // Adjust the padding to add spaces
              mainAxisSpacing: 30, // Add vertical space between the buttons
              crossAxisSpacing: 30, // Add horizontal space between the buttons
              childAspectRatio: 1.5,
              children: [
                KidActivityCard(
                  title: 'المقاطع القصيرة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideosPage(),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'المقاطع الطويلة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideosPage(),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'مقاطع ساكنة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideosPage(),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                  title: ' اول الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideosPage(),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'وسط الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideosPage(),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'اخر الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideosPage(),
                      ),
                    );
                  },
                ),
                // Add more activity cards as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KidActivityCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const KidActivityCard({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
