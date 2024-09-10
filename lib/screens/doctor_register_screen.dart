import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iasop/screens/docinfo_screen.dart';

class DoctorRegisterScreen extends StatefulWidget {
  @override
  _DoctorRegisterScreenState createState() => _DoctorRegisterScreenState();
}

class _DoctorRegisterScreenState extends State<DoctorRegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog("Passwords do not match");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Check if username exists
    bool usernameExists = await _checkIfUsernameExists(_usernameController.text.trim());
    if (usernameExists) {
      _showErrorDialog("Username already exists");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save the username in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
      });

      // Navigate to next screen after successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DocInfoScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? "Sign-up failed");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _checkIfUsernameExists(String username) async {
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    return documents.isNotEmpty;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

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
            _buildTextField(Icons.person, 'Username', controller: _usernameController),
            _buildTextField(Icons.email, 'E-mail', controller: _emailController),
            _buildTextField(Icons.lock, 'Password', controller: _passwordController, obscureText: true),
            _buildTextField(Icons.lock, 'Confirm password', controller: _confirmPasswordController, obscureText: true),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _signUp,
              child: Text('Create', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
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

  Widget _buildTextField(IconData icon, String hint, {bool obscureText = false, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
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