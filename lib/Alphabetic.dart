import 'package:flutter/material.dart';
import 'package:speech_aid/Excersise.dart';

class Alphabetic extends StatelessWidget {
  const Alphabetic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الاحرف العربية'),
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
        crossAxisCount: 4, // 4 columns

        padding: const EdgeInsets.all(10),
        childAspectRatio: 0.6,
        children: List.generate(28, (index) {
          // Generate Arabic alphabet letters
          String letter = _getArabicLetter(index);
          return LettersCard(
            title: letter,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Exercise()),
              );
            },
          );
        }),
      ),
    );
  }

  String _getArabicLetter(int index) {
    switch (index) {
      case 0:
        return 'أ';
      case 1:
        return 'ب';
      case 2:
        return 'ت';
      case 3:
        return 'ث';
      case 4:
        return 'ج';
      case 5:
        return 'ح';
      case 6:
        return 'خ';
      case 7:
        return 'د';
      case 8:
        return 'ذ';
      case 9:
        return 'ر';
      case 10:
        return 'ز';
      case 11:
        return 'س';
      case 12:
        return 'ش';
      case 13:
        return 'ص';
      case 14:
        return 'ض';
      case 15:
        return 'ط';
      case 16:
        return 'ظ';
      case 17:
        return 'ع';
      case 18:
        return 'غ';
      case 19:
        return 'ف';
      case 20:
        return 'ق';
      case 21:
        return 'ك';
      case 22:
        return 'ل';
      case 23:
        return 'م';
      case 24:
        return 'ن';
      case 25:
        return 'ه';
      case 26:
        return 'و';
      case 27:
        return 'ي';
      default:
        return '';
    }
  }
}

class LettersCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const LettersCard({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 30, // Adjust the width as needed
        height: 30, // Adjust the height as needed
        child: Card(
          elevation: 4,
          color: const Color(0xFFFFBBDB),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 40, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
