import 'package:flutter/material.dart';
import 'package:iasop/screens/docinfo_screen.dart';
import 'package:iasop/screens/doctor_profile_screen.dart';
import 'doctor_prof_screen.dart';

class DoctorRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let's Get Started!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 40),

            _buildTextField(Icons.person, 'Username'),
            _buildTextField(Icons.email, 'E-mail'),
            _buildTextField(Icons.lock, 'Password', obscureText: true),
            _buildTextField(Icons.lock, 'Confirm password', obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DocInfoScreen()),
                );
                // Perform registration
              },
              child: Text('Create',style:(TextStyle(color:Colors.white,))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to login screen
              },
              child: Text(
                'Already have an account? Login here',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 30),

            // Page Navigation Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dotIndicator(isActive: true),
                dotIndicator(isActive: false),
                dotIndicator(isActive: false),
                dotIndicator(isActive: false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.teal),
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
      ),
    );
  }

  Widget dotIndicator({required bool isActive}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 12.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.teal : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
