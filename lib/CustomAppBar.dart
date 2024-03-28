import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;
  final Function(String) onMenuItemSelected;
  final Widget title;

  const CustomAppBar({
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
                    SizedBox(width: 5),
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
            onMenuItemSelected(value);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class FriendlyDashboard extends StatefulWidget {
  const FriendlyDashboard({Key? key}) : super(key: key);

  @override
  _FriendlyDashboardState createState() => _FriendlyDashboardState();
}

class _FriendlyDashboardState extends State<FriendlyDashboard> {
  int notificationCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        notificationCount: notificationCount,
        onMenuItemSelected: (String value) {
          if (value == 'Log Out') {
            // Clear all routes and push login
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          } else if (value == 'Notification') {
            // Handle notification option
            setState(() {
              notificationCount = 0; // Reset notification count
            });
          }
        },
        title: const Text('الصفحة الرئيسية'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Your content here
            ],
          ),
        ),
      ),
    );
  }
}
