import 'package:flutter/material.dart';
import 'package:speech_aid/auth/signup.dart';
import 'package:speech_aid/auth/login.dart';

class secondpage extends StatelessWidget {
  const secondpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اشترك معنا'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'هيا نبدا',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color:
                    Colors.white, // Set text color to white for better contrast
                shadows: [
                  Shadow(color: Colors.black, blurRadius: 2)
                ], // Add a subtle shadow to make the text stand out
              ),
            ),

            ElevatedButton.icon(
              onPressed: () {
                // Handle sign in with Facebook
              },
              icon: Image.asset(
                'assets/facebook.jpg', // Assuming you have the Facebook logo image in your assets folder
                width: 24, // Adjust the size of the icon
                height: 24,
              ),
              label: const Text('اشترك مع الفيسبوك'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0), // Adjust button padding
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton.icon(
              onPressed: () {
                // Handle sign in with Google
              },
              icon: Image.asset(
                'assets/google.jpg', // Assuming you have the Google logo image in your assets folder
                width: 24, // Adjust the size of the icon
                height: 24,
              ),
              label: const Text('اشترك مع غوغل'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0), // Adjust button padding
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0), // Adjust button padding
              ),
              child: const Text('تسجيل دخول'),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'ليس لديك حساب؟:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _navigateToSignUpPage(context);
                  },
                  child: const Text('اشترك كمريض'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _navigateToSignUpPage(context);
                  },
                  child: const Text('اشترك كاخصائي'),
                ),
              ],
            ),
            Image.asset(
              'assets/image.png', // Assuming you have the Google logo image in your assets folder
              width: 150, // Adjust the size of the icon
              height: 150,
            ), // add the main logo
          ],
        ),
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context, String role) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => login(role: role)),
    );
  }

  void _navigateToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const signup()),
    );
  }
}
