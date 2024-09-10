import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iasop/screens/patient_home_screen.dart';
import 'package:iasop/screens/select_field_screen.dart';
import 'package:iasop/widgets/form_container_widget.dart';
import 'package:iasop/firebase_auth/firebase_auth_services.dart';
import 'package:iasop/global/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isSigning = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IASOP Logo
                Image.asset(
                  'images/img.png', // Update with your image path
                  height: 200.0,
                ),
                const SizedBox(height: 40),

                // Email TextField
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                const SizedBox(height: 20),

                // Password TextField
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                const SizedBox(height: 10),

                // Forgot Password
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.teal,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Button
                GestureDetector(
                  onTap: _signIn,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isSigning
                          ? CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Sign in options
                const Text(
                  'or sign in with',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Icon
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.google, color: Colors.red),
                      iconSize: 24,
                      onPressed: _signInWithGoogle,
                    ),
                    const SizedBox(width: 10),
                    // Apple Icon (Placeholder)
                    IconButton(
                      icon: Icon(FontAwesomeIcons.apple, color: Colors.black),
                      iconSize: 24,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    // Facebook Icon (Placeholder)
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                      iconSize: 24,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Create Account
                RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: ' Create one',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectFieldScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PatientHomeScreen()),
      );
    } else {
      showToast(message: "Some error occurred");
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PatientHomeScreen()),
        );
      }
    } catch (e) {
      showToast(message: "Some error occurred: $e");
    }
  }
}
