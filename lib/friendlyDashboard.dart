import 'package:flutter/material.dart';
import 'package:speech_aid/Excersise.dart';

class FriendlyDashboard extends StatelessWidget {
  const FriendlyDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'فلنبدا معا',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: 1.2,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 70), // Adjust padding
                        ),
                        child: const Text('تسجيلات',
                            style: TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/image.png',
                    width: 120,
                    height: 150,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image.png',
                    width: 120,
                    height: 150,
                  ),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.centerRight,
                      widthFactor: 1.2,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Excersise()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 70), // Adjust padding
                        ),
                        child: const Text('التمرينات',
                            style: TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
