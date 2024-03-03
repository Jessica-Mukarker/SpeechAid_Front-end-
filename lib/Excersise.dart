import 'package:flutter/material.dart';

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
                      SizedBox(width: 5),
                      Text(
                        'الحساب الشخصي',
                        style: TextStyle(
                          fontSize: 16,
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
                      SizedBox(width: 5),
                      Text(
                        'صفحة التسجيلات',
                        style: TextStyle(
                          fontSize: 16,
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
                      SizedBox(width: 5),
                      Text(
                        'تاريخ التسجيلات',
                        style: TextStyle(
                          fontSize: 16,
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
                      SizedBox(width: 5),
                      Text(
                        'موقع العيادة',
                        style: TextStyle(
                          fontSize: 16,
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
                      SizedBox(width: 5),
                      Text(
                        'معلومات المعالج',
                        style: TextStyle(
                          fontSize: 16,
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
                      SizedBox(width: 5),
                      Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'Log Out') {
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
        crossAxisCount: 3,
        padding: const EdgeInsets.all(8),
        children: [
          KidActivityCard(
            title: ' المقاطع القصيرة',
            icon: Icons.brush,
            onTap: () {
              // Handle activity tap
              // For example, navigate to the drawing screen
            },
          ),
          KidActivityCard(
            title: 'المقاطع الطويلة',
            icon: Icons.mic,
            onTap: () {
              // Handle activity tap
              // For example, navigate to the reading screen
            },
          ),
          KidActivityCard(
            title: 'كلمات',
            icon: Icons.book,
            onTap: () {
              // Handle activity tap
              // For example, navigate to the reading screen
            },
          ),
          KidActivityCard(
            title: 'كلمات',
            icon: Icons.book,
            onTap: () {
              // Handle activity tap
              // For example, navigate to the reading screen
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
