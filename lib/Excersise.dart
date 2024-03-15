import 'package:flutter/material.dart';
import 'package:speech_aid/RecordingScreen.dart';

class Exercise extends StatelessWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة التمرينات'),
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
                Navigator.popUntil(context,
                    ModalRoute.withName('/')); // Go back to the root page
                Navigator.pushReplacementNamed(
                    context, '/login'); // Navigate to the login page
              } else {
                // Handle other menu options
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Image added here
          Image.asset(
            'assets/image.png',
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(30), // Adjust the padding to add spaces
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
                          builder: (context) => const RecordingScreen()),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'المقاطع الطويلة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecordingScreen()),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'مقاطع ساكنة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecordingScreen()),
                    );
                  },
                ),
                KidActivityCard(
                  title: ' اول الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecordingScreen()),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'وسط الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecordingScreen()),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'اخر الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecordingScreen()),
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

class KidActivityCard extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const KidActivityCard({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _KidActivityCardState createState() => _KidActivityCardState();
}

class _KidActivityCardState extends State<KidActivityCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      child: Card(
        color: _pressed ? Color(0xFFFFBBDB) : Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.title,
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
