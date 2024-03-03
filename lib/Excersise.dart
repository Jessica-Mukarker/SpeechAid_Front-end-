import 'package:flutter/material.dart';
import 'package:speech_aid/RecordingScreen.dart';

class Excersise extends StatelessWidget {
  const Excersise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة التمرينات'),
        actions: [
          PopupMenuButton(
            icon: ClipOval(
              child: Image.asset(
                'assets/logo.png',
                width: 40, // Adjust the width and height as needed
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                const PopupMenuItem(
                  value: 'Profile',
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black, size: 24),
                      SizedBox(width: 10), // Increased width
                      Text(
                        'الحساب الشخصي',
                        style: TextStyle(
                          fontSize: 18, // Increased font size
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'Recordings',
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.mic, color: Colors.black, size: 24),
                      SizedBox(width: 10), // Increased width
                      Text(
                        'صفحة التسجيلات',
                        style: TextStyle(
                          fontSize: 18, // Increased font size
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'History',
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.history, color: Colors.black, size: 24),
                      SizedBox(width: 10), // Increased width
                      Text(
                        'تاريخ التسجيلات',
                        style: TextStyle(
                          fontSize: 18, // Increased font size
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'Therapist Hospital',
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.local_hospital, color: Colors.black, size: 24),
                      SizedBox(width: 10), // Increased width
                      Text(
                        'موقع العيادة',
                        style: TextStyle(
                          fontSize: 18, // Increased font size
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'Therapist Info',
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.black, size: 24),
                      SizedBox(width: 10), // Increased width
                      Text(
                        'معلومات المعالج',
                        style: TextStyle(
                          fontSize: 18, // Increased font size
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'Log Out',
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black, size: 24),
                      SizedBox(width: 10), // Increased width
                      Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          fontSize: 18, // Increased font size
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Add more menu items as needed
              ];
            },
            onSelected: (value) {
              if (value == 'Recordings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordingScreen()),
                );
              } else if (value == 'Log Out') {
                Navigator.pop(context); // Close the menu
                Navigator.pop(context); // Go back to the previous screen
              } else {
                // Handle other menu options
              }
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20), // Increased padding
        childAspectRatio: 2.5, // Adjust aspect ratio
        children: [
          KidActivityCard(
            title: ' المقاطع القصيرة',
            icon: Icons.brush,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordingScreen()),
              );
            },
          ),

          KidActivityCard(
            title: 'المقاطع الطويلة',
            icon: Icons.mic,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordingScreen()),
              );
            },
          ),

          KidActivityCard(
            title: 'كلمات',
            icon: Icons.book,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordingScreen()),
              );
            },
          ),
          KidActivityCard(
            title: 'الاحرف',
            icon: Icons.book,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordingScreen()),
              );
            },
          ),
          // Add more activity cards as needed
        ],
      ),
    );
  }
}

class KidActivityCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const KidActivityCard({
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
