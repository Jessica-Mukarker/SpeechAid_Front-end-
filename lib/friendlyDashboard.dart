import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:speech_aid/alphabetic.dart';

class FriendlyDashboard extends StatefulWidget {
  const FriendlyDashboard({Key? key}) : super(key: key);

  @override
  _FriendlyDashboardState createState() => _FriendlyDashboardState();
}

class _FriendlyDashboardState extends State<FriendlyDashboard> {
  int notificationCount = 0; // Initialize notification count
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        actions: [
          _buildPopupMenuButton(),
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
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                      child:
                          const Text('تسجيلات', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Image.asset(
                      'assets/image.png',
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/image.png',
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Alphabetic(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                      child: const Text('التمرينات',
                          style: TextStyle(fontSize: 20)),
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

  Widget _buildPopupMenuButton() {
    bool hasNotification = notificationCount > 0;

    return PopupMenuButton(
      icon: CircleAvatar(
        backgroundImage: AssetImage(
          'assets/${hasNotification ? 'logo_notification.png' : 'logo.png'}',
        ),
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          _buildPopupMenuItem('Profile', Icons.person, 'الحساب الشخصي'),
          _buildPopupMenuItem('Notification', Icons.notifications, 'الإشعارات',
              hasNotification ? Colors.red : Colors.black),
          _buildPopupMenuItem('Recordings', Icons.mic, 'صفحة التسجيلات'),
          _buildPopupMenuItem('History', Icons.history, 'تاريخ التسجيلات'),
          _buildPopupMenuItem(
              'Therapist Hospital', Icons.local_hospital, 'موقع العيادة'),
          _buildPopupMenuItem('Therapist Info', Icons.info, 'معلومات المعالج'),
          _buildPopupMenuItem('Log Out', Icons.logout, 'تسجيل الخروج'),
        ];
      },
      onSelected: (value) {
        if (value == 'Log Out') {
          _signOut();
        } else if (value == 'Notification') {
          setState(() {
            notificationCount = 0; // Reset notification count
          });
        } else {
          // Handle other menu items
        }
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem(String value, IconData icon, String title,
      [Color? textColor]) {
    return PopupMenuItem(
      value: value,
      height: 40,
      child: Row(
        children: [
          Icon(icon, color: textColor ?? Colors.black, size: 24),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _signOut() async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Navigate to login screen and clear route history
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);

      print('User signed out successfully.');
    } catch (error) {
      print('Error signing out: $error');
    }
  }
}
