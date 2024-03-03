import 'package:flutter/material.dart';
import 'package:speech_aid/friendlyDashboard.dart';
import 'signup.dart'; // Import the signup class

class login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String validUsername = 'jess';
  final String validPassword = 'jess';
  final String? role;

  login({Key? key, this.role}) : super(key: key);

  void _authenticateUser(BuildContext context) {
    String enteredUsername = _usernameController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    if (enteredUsername == validUsername && enteredPassword == validPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FriendlyDashboard()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('خطأ'),
            content: const Text(
                'اسم المستخدم أو كلمة المرور خاطئة\n يرجى المحاولة مرة أخرى'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('حسنا'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xFF528FAA), // Set background color
            padding:
                const EdgeInsets.symmetric(horizontal: 24), // Adjust padding
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60.0),
                const Text(
                  "مرحبا مجددا",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  "ضع معلوماتك لنبدا معا",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "اسم المستخدم",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "كلمة السر",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    prefixIcon: const Icon(Icons.password, color: Colors.white),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _authenticateUser(context);
                  },
                  child: const Text(
                    "تسجيل",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    primary: const Color.fromARGB(255, 255, 174, 229),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "هل نسيت كلمة السر ؟",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 174, 229),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to the signup screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const signup()),
                        );
                      },
                      child: const Text(
                        "اشترك معنا",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 174, 229),
                        ),
                      ),
                    ),
                    const Text(
                      "لا تملك حساب ؟",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/image.png', // Assuming you have the Google logo image in your assets folder
                  width: 200, // Adjust the size of the icon
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
