import 'package:flutter/material.dart';
import 'package:iasop/screens/d_home_screen.dart';


import 'doctor_profile_screen.dart';


class MyProfileScreen extends StatelessWidget {
  // List of image paths for the grid cards
  final List<String> imagePaths = [
    'images/img_4.png',
    'images/img_5.png',
    'images/img_29.png',
    'images/img_7.png',
    'images/img_13.png',
    'images/img_9.png',
    'images/img_10.png',
    'images/img_5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with Background Image, Gradient, and Overlay Container
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/img_24.png'), // Replace with your image asset
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.teal.withOpacity(0.6), // Teal gradient with opacity
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorProfileScreen(), // Navigate to DoctorProfileScreen
                        ),
                      );
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 16,
                  child: Icon(Icons.edit, color: Colors.white, size: 30),
                ),
                // Overlay Container positioned half in and half out of the background image
                Positioned(
                  top: 80,
                  left: 30,
                  right: 30,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Customized Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Keeps the circle shape
                            border: Border.all(
                              color: Colors.white38,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white38.withOpacity(0.4),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'images/img_6.png', // Replace with your doctor image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Dr. Smith',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'General Practitioner',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                                (index) => Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            // Statistics Row with Animated Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatColumn('3K+', 'Consultation', Icons.medical_services),
                  _buildStatColumn('120', 'Post', Icons.article),
                  _buildStatColumn('35K+', 'Followers', Icons.group),
                  _buildStatColumn('150', 'Following', Icons.person_add),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Grid of Images
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: imagePaths.length, // Number of items in the grid
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return _buildImageCard(imagePaths[index]); // Pass the image path
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, IconData icon) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.teal, size: 30),
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard(String imagePath) {
    return GestureDetector(
      onTap: () {
        // Handle image tap for popup or other actions
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        shadowColor: Colors.teal.withOpacity(0.5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath, // Use the provided image path
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
