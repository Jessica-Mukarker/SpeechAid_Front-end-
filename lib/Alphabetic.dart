import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:speech_aid/Constants.dart';
import 'package:speech_aid/CustomAppBar.dart';
import 'package:speech_aid/Excersise.dart';
import 'package:http/http.dart' as http;

class Alphabetic extends StatelessWidget {
  const Alphabetic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('الاحرف العربية'),
        notificationCount: 0, // Set notificationCount to 0 initially
        onMenuItemSelected: (String value) {
          // Handle menu item selection here
        },
        actions: [],
      ),
      body: GridView.count(
        crossAxisCount: 4, // 4 columns
        padding: const EdgeInsets.all(10), // Adjust the padding to add spaces
        mainAxisSpacing: 10, // Add vertical space between the buttons
        crossAxisSpacing: 10,
        childAspectRatio: 0.6,
        children: List.generate(28, (index) {
          // Generate Arabic alphabet letters
          String letter = _getArabicLetter(index);
          return LettersCard(
            title: letter,
            onTap: () async {
              getexcercisebyalpha(letter).then((value) {
                print(value);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Exercise(
                            exercicebylevel: value,
                            therapist_id: '',
                            exercise_id: '',
                            exerciseUrl: '',
                          )),
                );
              });
            },
          );
        }),
      ),
    );
  }

  Future<List> getexcercisebyalpha(String alpha) async {
    final url = "$EXERCICES?letter=$alpha";
    try {
      final response = await http.get(Uri.parse(url));
      print(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        List<dynamic> exercises = json.decode(response.body);
        print(exercises);
        return exercises;
      } else {
        // If the server did not return a 200 OK response, throw an exception
        return [];
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      // If an error occurs during the HTTP request, throw an exception
      return [];
      throw Exception('Failed to load exercises: $e');
    }
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

class LettersCard extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const LettersCard({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _LettersCardState createState() => _LettersCardState();
}

class _LettersCardState extends State<LettersCard> {
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
      child: Container(
        width: 80, // Specify the width
        height: 80, // Specify the height
        decoration: BoxDecoration(
          color: _pressed ? const Color(0xFFFFBBDB) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: _pressed
                  ? const Color(0xFFFFBBDB).withOpacity(0.5)
                  : Colors.transparent,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 30, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
