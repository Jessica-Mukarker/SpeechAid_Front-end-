import 'package:flutter/material.dart';
import 'package:speech_aid/Constants.dart';
import 'package:speech_aid/CustomAppBar.dart';
import 'package:speech_aid/RecordingScreen.dart';
import 'package:speech_aid/RecordingVideos.dart';
import 'package:speech_aid/RecordingVideosLong.dart';

class Exercise extends StatefulWidget {
  List exercicebylevel;
  final String therapist_id;
  final String exercise_id;
  final String exerciseUrl;

  Exercise({
    Key? key,
    required this.exercicebylevel,
    required this.therapist_id,
    required this.exercise_id,
    required this.exerciseUrl,
  }) : super(key: key);

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('الصفحة التمرينات'),
        notificationCount: 0, // Set notificationCount to 0 initially
        onMenuItemSelected: (String value) {
          // Handle menu item selection here
        },
        actions: [],
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
              padding:
                  const EdgeInsets.all(30), // Adjust the padding to add spaces
              mainAxisSpacing: 30, // Add vertical space between the buttons
              crossAxisSpacing: 30, // Add horizontal space between the buttons
              childAspectRatio: 1.5,
              children: [
                KidActivityCard(
                  title: 'المقاطع القصيرة',
                  onTap: () {
                    print(widget.exercicebylevel
                        .where(
                            (element) => element["exercise_level"] == "Short")
                        .first["exercise_id"]);
                    final id = widget.exercicebylevel
                        .where(
                            (element) => element["exercise_level"] == "Short")
                        .first["exercise_id"];
                    final url = widget.exercicebylevel
                        .where(
                            (element) => element["exercise_level"] == "Short")
                        .first["exercise_url"];
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RecordingScreen(
                    //       patient_id: '13',
                    //       therapist_id: '1',
                    //       exerciseUrl: baseurl + url,
                    //       exercise_id: id,
                    //     ),
                    //   ),
                    // );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordingVideos(
                          type: "Short",
                          exercicebylevel: widget.exercicebylevel,
                        ),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                    title: 'المقاطع الطويلة',
                    onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => RecordingScreen(
                      //         patient_id: '13',
                      //         therapist_id: '1',
                      //         exercise_id: exercicebylevel
                      //             .where((element) =>
                      //                 element["exercise_level"] == "Long")
                      //             .first["exercice_id"],
                      //         exerciseUrl: baseurl +
                      //             exercicebylevel
                      //                 .where((element) =>
                      //                     element["exercise_level"] == "Long")
                      //                 .first["exercise_url"],
                      //       ),
                      //     ),
                      //   );
                      // },

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecordingVideosLong(
                            type: "Long",
                            exercicebylevel: widget.exercicebylevel,
                          ),
                        ),
                      );
                    }),
                KidActivityCard(
                  title: 'مقاطع ساكنة',
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RecordingScreen(
                    //       patient_id: '13',
                    //       therapist_id: '1',
                    //       exerciseUrl: baseurl +
                    //           widget.exercicebylevel
                    //               .where((element) =>
                    //                   element["exercise_level"] == "Silent" &&
                    //                   element["exercise_letter"])
                    //               .first["exercise_url"],
                    // exercise_id: widget.exercicebylevel
                    //     .where((element) =>
                    //         element["exercise_level"] == "Silent" &&
                    //         element["exercise_letter"])
                    //     .first["exercice_id"],
                    //     ),
                    // //   ),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordingScreen(
                            patient_id: '13',
                            therapist_id: '1',
                            exerciseUrl: baseurl +
                                widget.exercicebylevel
                                    .where((element) =>
                                        element["exercise_level"] == "Silent")
                                    .first["exercise_url"],
                            exercise_id: widget.exercicebylevel
                                .where((element) =>
                                    element["exercise_level"] == "Silent")
                                .first["exercise_id"]),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                  title: ' اول الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordingScreen(
                            patient_id: '13',
                            therapist_id: '1',
                            exerciseUrl: baseurl +
                                widget.exercicebylevel
                                    .where((element) =>
                                        element["exercise_level"] == "Start")
                                    .first["exercise_url"],
                            exercise_id: widget.exercicebylevel
                                .where((element) =>
                                    element["exercise_level"] == "Start")
                                .first["exercise_id"]),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'وسط الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordingScreen(
                          patient_id: '13',
                          therapist_id: '1',
                          exerciseUrl: baseurl +
                              widget.exercicebylevel
                                  .where((element) =>
                                      element["exercise_level"] == "Middle")
                                  .first["exercise_url"],
                          exercise_id: widget.exercicebylevel
                              .where((element) =>
                                  element["exercise_level"] == "Middle")
                              .first["exercise_id"],
                        ),
                      ),
                    );
                  },
                ),
                KidActivityCard(
                  title: 'اخر الكلمة',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordingScreen(
                            patient_id: '13',
                            therapist_id: '1',
                            exerciseUrl: baseurl +
                                widget.exercicebylevel
                                    .where((element) =>
                                        element["exercise_level"] == "End")
                                    .first["exercise_url"],
                            exercise_id: widget.exercicebylevel
                                .where((element) =>
                                    element["exercise_level"] == "End")
                                .first["exercise_id"]),
                      ),
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
        color: const Color.fromARGB(255, 255, 255, 255),
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
