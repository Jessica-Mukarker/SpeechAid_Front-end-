import 'package:flutter/material.dart';
import 'package:speech_aid/PatientProfileScreen%20.dart';
import 'package:speech_aid/therapist/ShowRecording%20copy.dart';

import 'TherapistInfoPage.dart';

import 'PatientNotificationPage.dart'; // Import the patient notification page

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;
  final Function(String) onMenuItemSelected;
  final Widget title;

  const CustomAppBar({
    Key? key,
    required this.notificationCount,
    required this.onMenuItemSelected,
    required this.title,
    required List<Widget> actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasNotification = notificationCount > 0;

    return AppBar(
      title: title,
      actions: [
        PopupMenuButton(
          icon: Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/${hasNotification ? 'logo_notification.png' : 'logo.png'}',
                ),
              ),
              if (notificationCount > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
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
              PopupMenuItem(
                value: 'Notification',
                height: 40,
                child: Row(
                  children: [
                    Icon(Icons.notifications,
                        color: hasNotification ? Colors.red : Colors.black,
                        size: 24),
                    const SizedBox(width: 5),
                    Text(
                      'الإشعارات',
                      style: TextStyle(
                        fontSize: 16,
                        color: hasNotification ? Colors.red : Colors.black,
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
              /*      const PopupMenuItem(
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
              ),*/
              const PopupMenuItem(
                value: 'Therapist Info',
                height: 40,
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.black, size: 24),
                    SizedBox(width: 5),
                    Text(
                      'معلومات الأخصائي',
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
              // Call the logout method and pass the BuildContext
              onLogout(context);
            } else if (value == 'Profile') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PatientProfileScreen()),
              );
            } else if (value == 'Therapist Info') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TherapistInfoPage(
                    therapistName: 'Dr. John Doe',
                    phoneNumber: '+1234567890',
                    address: '123 Main Street, City, Country',
                    age: 40,
                    hospital: 'XYZ',
                  ),
                ),
              );
            } else if (value == 'Recordings') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShowRecording(),
                ),
              );
            } else if (value == 'Notification') {
              // Navigate to PatientNotificationPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientNotificationPage(),
                ),
              );
            } else {
              // Call the callback function for other menu items
              onMenuItemSelected(value);
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void onLogout(BuildContext context) {
    // Pop all routes until reaching the login screen
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
