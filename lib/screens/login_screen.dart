import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iasop/screens/doctor_profile_screen.dart';
import 'package:iasop/screens/patient_home_screen.dart';
import 'package:iasop/screens/select_field_screen.dart';

 // Import the home screen

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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

              // Username TextField
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password TextField
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Forgot Password
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'forgot password?',
                  style: TextStyle(
                    color: Colors.teal,
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the home screen after login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>PatientHomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ), // background color
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 18, color: Colors.white),
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
                    icon: Image.asset('images/img_11.png'),
                    iconSize: 5,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  // Apple Icon
                  IconButton(
                    icon: Image.asset('images/img_2.png'),
                    iconSize: 5,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  // Facebook Icon
                  IconButton(
                    icon: Image.asset('images/img_3.png'),
                    iconSize: 5,
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
                          // Navigate to the SelectFieldScreen when "Create one" is clicked
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SelectFieldScreen()),
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
    );
  }
}

