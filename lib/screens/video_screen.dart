import 'package:flutter/material.dart';
import 'package:iasop/screens/d_home_screen.dart';
import 'package:iasop/screens/vid_screen.dart';

import 'mes_screen.dart';

class VideoScreen extends StatelessWidget {
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
            bottom: 80.0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '5:33',
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
            bottom: 20.0,
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
                  icon: Icon(Icons.message_outlined, color: Colors.teal),
                  iconSize: 36.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VidScreen()),
                    );// Handle message action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call_end, color: Colors.red),
                  iconSize: 36.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DHomeScreen()),
                    );// Handle end call action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
