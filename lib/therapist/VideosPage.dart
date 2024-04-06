import 'package:flutter/material.dart';
import 'package:speech_aid/therapist/AddVideoScreen.dart';
import 'package:speech_aid/therapist/DeleteVideoScreen.dart';
import 'package:speech_aid/therapist/EditVideoScreen.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة التمارين'),
        actions: [
          IconButton(
            onPressed: () {
              // Handle action
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddVideoScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add,
                            color: const Color.fromARGB(255, 255, 174, 229),
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          const Text(
                            'اضافة ',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeleteVideoScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.remove,
                            color: const Color(0xFF528FAA),
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          const Text(
                            'ازالة ',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditVideoScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.edit,
                            color: const Color(0xFF528FAA),
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          const Text(
                            'تعديل ',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.block,
                            color: const Color.fromARGB(255, 255, 174, 229),
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          const Text(
                            'حظر ',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/image.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
