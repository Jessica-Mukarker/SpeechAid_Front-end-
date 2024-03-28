import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speech_aid/friendlyDashboard.dart';
import 'signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

class login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String validUsername = 'jess';
  final String validPassword = 'jess';
  final String? role;

  login({Key? key, this.role}) : super(key: key);

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
//////
      print('Google user: $googleUser');
      print('Google auth: $googleAuth');
      //////////

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context)
          .pushNamedAndRemoveUntil("dashboard", (route) => false);
    } catch (e) {
      print('Google Sign-In Error: $e');
      // Handle Google Sign-In errors here
    }
  }

  void _authenticateUser(BuildContext context) {
    String enteredUsername = _emailController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    if (enteredUsername == validUsername && enteredPassword == validPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  FriendlyDashboard()),
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
                  controller: _emailController,
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
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                      Navigator.pushReplacementNamed(context, "dashboard");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          //borderSide: BorderSide(color: Colors.green, width: 2),
                          //buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                          // headerAnimationLoop: false,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'No user found for that email.',
                          //showCloseIcon: true,
                          // btnCancelOnPress: () {},
                          //btnOkOnPress: () {},
                        ).show();
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          //borderSide: BorderSide(color: Colors.green, width: 2),
                          //buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                          //headerAnimationLoop: false,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Wrong password provided for that user.',
                          //showCloseIcon: true,
                          //btnCancelOnPress: () {},
                          //btnOkOnPress: () {},
                        ).show();
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    backgroundColor: const Color.fromARGB(255, 255, 174, 229),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "تسجيل",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "أو",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    // Navigate to the login screen
                    signInWithGoogle(context); // Pass the context here
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/google.jpg'),
                        radius: 15,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "تسجيل الدخول بواسطة جوجل",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 174, 229),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                              builder: (context) =>
                                  const signup()), // Corrected class name
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
