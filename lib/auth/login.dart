import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_aid/Constants.dart';
import 'package:speech_aid/friendlyDashboard.dart';
import 'package:speech_aid/therapist/therapistDashbored.dart';
import 'signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

class login extends StatefulWidget {
  final String? role;

  const login({Key? key, this.role}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String type = '';
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final String validUsername = 'jess';

  final String validPassword = 'jess';
  bool _passwordVisible = false; // State variable to track password visibility

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

  Future<void> loginUser() async {
    String url = Auth; // Replace with your server URL
    print(url);
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, String> body = {
      "email": _emailController.text,
      "password": _passwordController.text,
      "type": type
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    print(response.body);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      // Handle response according to your needs
// Save user data to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (responseData["who"] == "therapist") {
        await prefs.setString('therapist_id',
            responseData["therapist"]["therapist_id"].toString());
        await prefs.setString('who', responseData["who"]);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const therapistDashboard())); // Navigate to next screen or perform necessary action
      } else if (responseData["who"] == "patient") {
        await prefs.setString(
            'patient_id', responseData["patient"]["patient_id"].toString());
        await prefs.setString('who', responseData["who"]);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FriendlyDashboard()));
      } else {
        print('err');
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => FriendlyDashboard()));
      }
    } else {
      print("Error: ${response.reasonPhrase}");
    }
  }

  void _authenticateUser(BuildContext context) {
    String enteredUsername = _emailController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    if (enteredUsername == validUsername && enteredPassword == validPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FriendlyDashboard()),
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
    String? seletcedtype;
    String? selectedItem;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('صفحة التسجيل'),
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
                    hintText: "البريد الالكتروني",
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                ),
                const SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton<String>(
                          child: type == ''
                              ? const Text(
                                  'من أنت',
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(type,
                                  style: const TextStyle(color: Colors.white)),
                          onSelected: (value) {
                            print(value);
                            setState(() {
                              type = value;
                            });
                            print(type);
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                value: 't',
                                child: Text('أخصائي'),
                              ),
                              const PopupMenuItem(
                                value: 'p',
                                child: Text('مريض'),
                              ),
                            ];
                          }),
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    loginUser();
                    // try {
                    //   final credential = await FirebaseAuth.instance
                    //       .signInWithEmailAndPassword(
                    //           email: _emailController.text,
                    //           password: _passwordController.text);
                    //   Navigator.pushReplacementNamed(context, "dashboard");
                    // } on FirebaseAuthException catch (e) {
                    //   if (e.code == 'user-not-found') {
                    //     AwesomeDialog(
                    //       context: context,
                    //       dialogType: DialogType.error,
                    //       //borderSide: BorderSide(color: Colors.green, width: 2),
                    //       //buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                    //       // headerAnimationLoop: false,
                    //       animType: AnimType.rightSlide,
                    //       title: 'Error',
                    //       desc: 'No user found for that email.',
                    //       //showCloseIcon: true,
                    //       // btnCancelOnPress: () {},
                    //       //btnOkOnPress: () {},
                    //     ).show();
                    //     print('No user found for that email.');
                    //   } else if (e.code == 'wrong-password') {
                    //     AwesomeDialog(
                    //       context: context,
                    //       dialogType: DialogType.error,
                    //       //borderSide: BorderSide(color: Colors.green, width: 2),
                    //       //buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                    //       //headerAnimationLoop: false,
                    //       animType: AnimType.rightSlide,
                    //       title: 'Error',
                    //       desc: 'Wrong password provided for that user.',
                    //       //showCloseIcon: true,
                    //       //btnCancelOnPress: () {},
                    //       //btnOkOnPress: () {},
                    //     ).show();
                    //     print('Wrong password provided for that user.');
                    //   }
                    // }
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
