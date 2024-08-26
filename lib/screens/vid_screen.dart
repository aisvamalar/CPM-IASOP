import 'package:flutter/material.dart';
import 'package:iasop/screens/d_home_screen.dart';
import 'package:iasop/screens/video_screen.dart';

import 'mes_screen.dart';

class VidScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main video (large one)
          Positioned.fill(
            child: Image.asset(
              'images/img_43.png', // Replace with the URL of your main video stream
              fit: BoxFit.cover,
            ),
          ),
          // Small video (small one)
          Positioned(
            top: 20.0,
            right: 20.0,
            child: Container(
              width: 120.0,
              height: 160.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'images/img_44.png', // Replace with the URL of your small video stream
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Call duration text
          Positioned(
            bottom: 150.0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '7:49',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Bottom controls
          Positioned(
            bottom: 180.0, // Adjust this value to position above the chat section
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.note_alt_outlined, color: Colors.teal),
                  iconSize: 36.0,
                  onPressed: () {
                    // Handle note action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.mic_off, color: Colors.teal),
                  iconSize: 36.0,
                  onPressed: () {
                    // Handle mute action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_box, color: Colors.teal),
                  iconSize: 36.0,
                  onPressed: () {
                    // Handle add action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.videocam, color: Colors.teal),
                  iconSize: 36.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MesScreen()),
                    );// Handle video on/off action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call_end, color: Colors.red),
                  iconSize: 40.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoScreen()),
                    );// Handle end call action
                  },
                ),
              ],
            ),
          ),
          // Chat section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,

            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Colors.white60,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Chat messages
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.teal[100], // Light teal color for received messages
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                                bottomRight: Radius.circular(16.0),
                              ),
                            ),
                            child: Text(
                              "How long have you been feeling this way?",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.teal[50], // Lighter teal color for sent messages
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                                bottomLeft: Radius.circular(16.0),
                              ),
                            ),
                            child: Text(
                              "It's been about two weeks now. It started as just mild fatigue, but it's been getting worse.",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Text input field
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "How can I help you today?",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.teal[50], // Light teal color for the input field
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: Colors.teal),
                        onPressed: () {
                          // Handle send action
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
