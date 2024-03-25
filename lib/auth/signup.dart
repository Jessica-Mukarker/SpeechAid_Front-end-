import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart'; // Import the login class

class signup extends StatefulWidget {
  const signup({Key? key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();

  bool isSigningUp = false;
  String? _selectedItem;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xFF528FAA), // Set background color
            padding:
                const EdgeInsets.symmetric(horizontal: 24), // Adjust padding
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 60.0),
                const Text(
                  "اشترك معنا",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/image.png',
                  width: 150, // Adjust the size of the icon
                  height: 150,
                ),
                const SizedBox(height: 20),
                Text(
                  "اعمل الحساب الخاص بك",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey[200]),
                ),
                const SizedBox(height: 40),
                TextField(
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
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
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
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "تاريخ الميلاد",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    prefixIcon:
                        const Icon(Icons.calendar_today, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Color(0xFF75A5BB),
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Icon(Icons.arrow_drop_down, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "هل انت",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      value: _selectedItem,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem = newValue;
                        });
                      },
                      items: <String>['الاخصائي', 'المريض']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final credential =
                                await _auth.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (credential != null) {
                              Navigator.pushReplacementNamed(
                                  context, "friendlyDashboard");
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 174, 229),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24), // Adjust padding
                        ),
                        child: const Text(
                          "اشترك",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
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
                        "اشترك بواسطة جوجل",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 174, 229),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "لديك حساب مسبقا ؟",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to the login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
                      },
                      child: const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 174, 229)),
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
