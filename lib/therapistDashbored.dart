import 'package:flutter/material.dart';

class therapistDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة الاخصائي'),
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
            padding: const EdgeInsets.all(20.0), // Padding around the buttons
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/image.png',
                  width: 150, // Adjust the size of the icon
                  height: 150,
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2, // Two columns
                  mainAxisSpacing: 10, // Spacing between rows
                  crossAxisSpacing: 10, // Spacing between columns
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle button 1 action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.1,
                        ),
                        minimumSize: const Size(double.infinity, 60),
                        // Set button height
                      ),
                      child: const Text(
                        'المستخدم',
                        style: TextStyle(fontSize: 20),
                        // Set button text size
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle button 2 action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.1,
                        ),
                        minimumSize: const Size(double.infinity, 60),
                        // Set button height
                      ),
                      child: const Text(
                        'Button 2',
                        style: TextStyle(fontSize: 20),
                        // Set button text size
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle button 3 action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.1,
                        ),
                        minimumSize: const Size(double.infinity, 60),
                        // Set button height
                      ),
                      child: const Text(
                        'Button 3',
                        style: TextStyle(fontSize: 20),
                        // Set button text size
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle button 4 action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.1,
                        ),
                        minimumSize: const Size(double.infinity, 60),
                        // Set button height
                      ),
                      child: const Text(
                        'Button 4',
                        style: TextStyle(fontSize: 20),
                        // Set button text size
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
