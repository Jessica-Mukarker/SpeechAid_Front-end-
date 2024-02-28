// WelcomePage.dart
import 'package:flutter/material.dart';

import 'auth/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 200,
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  '   مرحبًا \n فلنبدأ هنا',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 174, 229),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffffaee5), // Button color
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    iconSize: 60,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
