
import 'package:flutter/material.dart';
import 'package:speech_aid/Constants.dart';
import 'package:speech_aid/CustomAppBar.dart';
import 'package:speech_aid/RecordingScreen.dart';

class RecordingVideos extends StatelessWidget {
  List exercicebylevel;
  String type;
  RecordingVideos({Key? key, required this.type, required this.exercicebylevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('الصفحة التمرينات'),
        notificationCount: 0, // Set notificationCount to 0 initially
        onMenuItemSelected: (String value) {
          // Handle menu item selection here
        }, actions: [],
      ),
      body: Column(
        children: [
          // Image added here
          Image.asset(
            'assets/image.png',
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print(exercicebylevel
                          .where((element) =>
                              element["exercise_level"] == type &&
                              element["exercise_letter"]
                                  .toString()
                                  .contains("ُ"))
                          .first["exercise_id"]);

                      final id = exercicebylevel
                          .where((element) =>
                              element["exercise_level"] == type &&
                              element["exercise_letter"]
                                  .toString()
                                  .contains("ُ"))
                          .first["exercise_id"];
                      final url = exercicebylevel
                          .where((element) =>
                              element["exercise_level"] == type &&
                              element["exercise_letter"]
                                  .toString()
                                  .contains("ُ"))
                          .first["exercise_url"];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecordingScreen(
                            patient_id: '13',
                            therapist_id: '1',
                            exerciseUrl: baseurl + url,
                            exercise_id: id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "الضمة",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print(exercicebylevel
                          .where((element) =>
                              element["exercise_level"] == type &&
                              element["exercise_letter"]
                                  .toString()
                                  .contains("َ"))
                          .first["exercise_id"]);

                      final id = exercicebylevel
                          .where((element) =>
                              element["exercise_level"] == type &&
                              element["exercise_letter"]
                                  .toString()
                                  .contains("َ"))
                          .first["exercise_id"];
                      final url = exercicebylevel
                          .where((element) =>
                              element["exercise_level"] == type &&
                              element["exercise_letter"]
                                  .toString()
                                  .contains("َ"))
                          .first["exercise_url"];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecordingScreen(
                            patient_id: '13',
                            therapist_id: '1',
                            exerciseUrl: baseurl + url,
                            exercise_id: id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "الفتحة",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print(exercicebylevel
                  .where((element) =>
                      element["exercise_level"] == type &&
                      element["exercise_letter"].toString().contains("ِ"))
                  .first["exercise_id"]);

              final id = exercicebylevel
                  .where((element) =>
                      element["exercise_level"] == type &&
                      element["exercise_letter"].toString().contains("ِ"))
                  .first["exercise_id"];
              final url = exercicebylevel
                  .where((element) =>
                      element["exercise_level"] == type &&
                      element["exercise_letter"].toString().contains("ِ"))
                  .first["exercise_url"];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordingScreen(
                    patient_id: '13',
                    therapist_id: '1',
                    exerciseUrl: baseurl + url,
                    exercise_id: id,
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 130,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  "الكسرة",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KidActivityCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const KidActivityCard({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
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
