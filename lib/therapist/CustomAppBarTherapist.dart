import 'package:flutter/material.dart';
import 'package:speech_aid/therapist/DoctorProfileScreen%20.dart';

class CustomAppBarTherapist extends StatelessWidget
    implements PreferredSizeWidget {
  final int notificationCount;
  final Function(String) onMenuItemSelected;
  final Widget title;

  const CustomAppBarTherapist({
    Key? key,
    required this.notificationCount,
    required this.onMenuItemSelected,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasNotification = notificationCount > 0;

    return AppBar(
      title: title,
      actions: [
        PopupMenuButton(
          icon: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/${hasNotification ? 'logo_notification.png' : 'logo.png'}',
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
              // Navigate to DoctorProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DoctorProfileScreen()),
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