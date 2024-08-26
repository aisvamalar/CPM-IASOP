import 'package:flutter/material.dart';
import 'package:iasop/screens/doctor_profile_screen.dart';

import 'doc_profile_screen.dart';
import 'doctor_prof_screen.dart';

class DoctorsScreen extends StatefulWidget {
  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Deepak' ,
      'specialty': 'Urologist',
      'reviews': '136 reviews',
      'image': 'images/img_18.png',
    },
    {
      'name': 'Dr. Rayyani',
      'specialty': 'Oncologist',
      'reviews': '120 reviews',
      'image': 'images/file_(2)[1].png',
    },
    {
      'name': 'Dr. Abinash',
      'specialty': 'Urologist',
      'reviews': '136 reviews',
      'image': 'images/file_(3)[1].png',
    },
    {
      'name': 'Dr. Rahul',
      'specialty': 'Oncologist',
      'reviews': '120 reviews',
      'image': 'images/file_(4)[1].png',
    },
    {
      'name': 'Dr. Sana',
      'specialty': 'Urologist',
      'reviews': '136 reviews',
      'image': 'images/file (5).png',
    },
    {
      'name': 'Dr. Vishitha',
      'specialty': 'Oncologist',
      'reviews': '120 reviews',
      'image': 'images/file (6).png',
    },
    {
      'name': 'Dr. Santhiya',
      'specialty': 'Urologist',
      'reviews': '136 reviews',
      'image': 'images/file (7).png',
    },
    {
      'name': 'Dr. Priya',
      'specialty': 'Oncologist',
      'reviews': '120 reviews',
      'image': 'images/file (8).png',
    },
    // Add more doctors here
  ];

  List<Map<String, dynamic>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctors; // Initialize with full list
  }

  void filterDoctors(String query) {
    final suggestions = doctors.where((doctor) {
      final doctorName = doctor['name'].toLowerCase();
      final input = query.toLowerCase();
      return doctorName.contains(input);
    }).toList();

    setState(() {
      filteredDoctors = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: filterDoctors, // Update the list as user types
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for doctors',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.teal[50],
              ),
            ),


        // Example Doctor Card

            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  return DoctorCardScreen(
                    name: filteredDoctors[index]['name'],
                    specialty: filteredDoctors[index]['specialty'],
                    reviews: filteredDoctors[index]['reviews'],
                    image: filteredDoctors[index]['image'],
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle view more action
              },
              child: Text('View More ->'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal, // Text color
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCardScreen extends StatefulWidget {
  final String name;
  final String specialty;
  final String reviews;
  final String image;

  const DoctorCardScreen({
    required this.name,
    required this.specialty,
    required this.reviews,
    required this.image,
  });

  @override
  _DoctorCardScreenState createState() => _DoctorCardScreenState();
}

class _DoctorCardScreenState extends State<DoctorCardScreen> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocProfileScreen(),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.teal[50],
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: isHovered ? Colors.teal.withOpacity(0.5) : Colors.grey.withOpacity(0.3),
              spreadRadius: isHovered ? 4 : 2,
              blurRadius: isHovered ? 10 : 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(widget.image),
              ),
              SizedBox(height: 8.0),
              Text(
                widget.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                widget.specialty,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow[700], size: 16.0),
                  Icon(Icons.star, color: Colors.yellow[700], size: 16.0),
                  Icon(Icons.star, color: Colors.yellow[700], size: 16.0),
                  Icon(Icons.star, color: Colors.yellow[700], size: 16.0),
                  Icon(Icons.star_half, color: Colors.yellow[700], size: 16.0),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                widget.reviews,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}