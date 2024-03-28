import 'package:flutter/material.dart';
import 'package:speech_aid/CustomAppBar.dart';
import 'package:speech_aid/alphabetic.dart';


class FriendlyDashboard extends StatefulWidget {
  const FriendlyDashboard({Key? key}) : super(key: key);

  @override
  _FriendlyDashboardState createState() => _FriendlyDashboardState();
}

class _FriendlyDashboardState extends State<FriendlyDashboard> {
  int notificationCount = 0; // Initialize notification count

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('الصفحة الرئيسية'),
        notificationCount: notificationCount,
        onMenuItemSelected: (String value) {
          // Handle menu item selection here
          if (value == 'Notification') {
            // Handle notification option
            setState(() {
              notificationCount = 0; // Reset notification count
            });
          }
        }, 
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
}
