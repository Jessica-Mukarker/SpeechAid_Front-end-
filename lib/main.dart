import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:speech_aid/auth/login.dart';
import 'package:speech_aid/firebase_options.dart';
import 'package:speech_aid/WelcomePage.dart';
import 'package:speech_aid/therapist/therapistDashbored.dart';
import 'auth/signup.dart';
import 'friendlyDashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('======User is currently signed out!');
      } else {
        print('======User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeechAid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            const Color(0xFF528FAA), // Background color for the whole app
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const FriendlyDashboard()
          : const FriendlyDashboard(),
      routes: {
        "signup": (context) => const signup(),
        'login': (context) => login(),
        'dashboard': (context) => const FriendlyDashboard()
      },
    );
  }
}
