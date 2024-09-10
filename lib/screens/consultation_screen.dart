import 'package:flutter/material.dart';
import 'package:iasop/screens/slot_screen.dart';

import 'd_home_screen.dart';

class ConsultationScreen extends StatefulWidget {
  @override
  _ConsultationScreenState createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  // Track selected methods
  bool _isDirectSelected = false;
  bool _isOnlineSelected = false;
  bool _isChatSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // First Container with Gradient Background and Title
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF04352F), Color(0xFF0B9B8A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Choose Your Consultation!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Image.asset(
                        'images/img_32.png', // Replace with your image asset
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Checkbox options for selecting multiple methods
                CheckboxListTile(
                  title: Text('Direct'),
                  value: _isDirectSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isDirectSelected = value ?? false;
                    });
                  },
                  secondary: Image.asset(
                    'images/img_33.png', // Replace with your image asset
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
                CheckboxListTile(
                  title: Text('Online'),
                  value: _isOnlineSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isOnlineSelected = value ?? false;
                    });
                  },
                  secondary: Image.asset(
                    'images/img_34.png', // Replace with your image asset
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
                CheckboxListTile(
                  title: Text('Chat'),
                  value: _isChatSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChatSelected = value ?? false;
                    });
                  },
                  secondary: Image.asset(
                    'images/img_35.png', // Replace with your image asset
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),

                // Continue Button to go to SlotScreen with selected methods
                ElevatedButton(
                  onPressed: () {
                    List<String> selectedMethods = [];
                    if (_isDirectSelected) selectedMethods.add('Direct appointment');
                    if (_isOnlineSelected) selectedMethods.add('Online appointment');
                    if (_isChatSelected) selectedMethods.add('Chat appointment');

                    if (selectedMethods.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SlotScreen(selectedMethods: selectedMethods, selectedMethod: '',),
                        ),
                      );
                    } else {
                      // Show a message to select at least one method
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select at least one consultation method.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Text('Continue', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 30),

                // Page Navigation Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    dotIndicator(isActive: false),
                    dotIndicator(isActive: false),
                    dotIndicator(isActive: true),
                    dotIndicator(isActive: false),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dotIndicator({required bool isActive}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.teal : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}