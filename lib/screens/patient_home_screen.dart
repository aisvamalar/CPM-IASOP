import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iasop/screens/doctors_screen.dart';
import 'package:iasop/screens/patient_profile_screen.dart';
import 'package:iasop/screens/pcalendar_screen.dart';
import 'package:iasop/screens/psettings_screen.dart';
import 'package:iasop/screens/schedule_screen.dart';
import 'package:iasop/screens/story_screen.dart';
import 'medication_screen.dart';
import 'mes_screen.dart';
import 'music_therapy_screen.dart';
import 'message_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

void main() {
  runApp(MaterialApp(
    home: PatientHomeScreen(),
  ));
}

class ScheduleCard extends StatelessWidget {
  final String doctorName;
  final String doctorTitle;
  final String date;
  final String time;
  final String appointmentType;
  final String imagePath;

  const ScheduleCard({
    Key? key,
    required this.doctorName,
    required this.doctorTitle,
    required this.date,
    required this.time,
    required this.appointmentType,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 2),
      interval: Duration(seconds: 2),
      color: Colors.white,
      colorOpacity: 0.3,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        width: 300,  // Adjusted width
        height: 180, // Reduced height
        child: Card(
          color: Colors.teal[200],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40, // Adjusted radius
                  backgroundImage: AssetImage(imagePath),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        doctorName,
                        style: TextStyle(
                          fontSize: 18, // Adjusted font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        doctorTitle,
                        style: TextStyle(
                          fontSize: 16, // Adjusted font size
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 8),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 14, // Adjusted font size
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14, // Adjusted font size
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.message, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MesScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SurfDoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String imagePath;

  const SurfDoctorCard({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.teal[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientProfileScreen()), // Replace with your PatientScreen
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 40,
              ),
            ),
            SizedBox(height: 10),
            Text(
              doctorName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              specialty,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(Icons.message, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessageScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PatientHomeScreen extends StatefulWidget {
  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    PatientHomeScreenContent(), // Home screen content
    PCalendarScreen(), // Schedule screen
    StoryScreen(), // Story screen
    PSettingsScreen(),
    MusicTherapyScreen(), // Music Therapy screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('images/img_1.png'),
            radius: 35,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _widgetOptions[_selectedIndex],
          ),
          ResponsiveNavBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
    );
  }
}

class PatientHomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> medications = [
      {'name': 'Avil', 'icon': FontAwesomeIcons.pills},
      {'name': 'Herbal Tea', 'icon': FontAwesomeIcons.mugHot},
      {'name': 'Vitamin C', 'icon': FontAwesomeIcons.appleAlt},
      {'name': 'Paracetamol', 'icon': FontAwesomeIcons.tablets},
      {'name': 'Ibuprofen', 'icon': FontAwesomeIcons.capsules},
      {'name': 'Antibiotics', 'icon': FontAwesomeIcons.syringe},
      {'name': 'Cough Syrup', 'icon': FontAwesomeIcons.prescriptionBottle},
      {'name': 'Antacids', 'icon': FontAwesomeIcons.prescriptionBottleAlt},
      {'name': 'Antiseptic Cream', 'icon': FontAwesomeIcons.firstAid},
      {'name': 'Bandages', 'icon': FontAwesomeIcons.bandAid},
      {'name': 'Inhaler', 'icon': FontAwesomeIcons.wind},
      {'name': 'Thermometer', 'icon': FontAwesomeIcons.thermometerHalf},
      {'name': 'Eye Drops', 'icon': FontAwesomeIcons.eyeDropper},
    ];

    final List<Map<String, dynamic>> healthTools = [
      {'name': 'DR.IASO', 'icon': FontAwesomeIcons.userMd},
      {'name': 'IASO', 'icon': FontAwesomeIcons.heartbeat},
      {'name': 'Search for medicine', 'icon': FontAwesomeIcons.chartLine},
    ];

    final List<Map<String, dynamic>> surfDoctors = [
      {'doctorName': 'Dr. Nareshi', 'specialty': 'Dentist', 'imagePath': 'images/file[1].png'},
      {'doctorName': 'Dr. Smith', 'specialty': 'Cardiologist', 'imagePath': 'images/file_(2)[1].png'},
      {'doctorName': 'Dr. brindha', 'specialty': 'Dentist', 'imagePath': 'images/file_(3)[1].png'},
      {'doctorName': 'Dr. Smith', 'specialty': 'Cardiologist', 'imagePath': 'images/file_(4)[1].png'},
      {'doctorName': 'Dr. Naresh', 'specialty': 'Dentist', 'imagePath': 'images/file(5).png'},
      {'doctorName': 'Dr. Smith', 'specialty': 'Cardiologist', 'imagePath': 'images/file(6).png'},

    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Julie',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            Text('female - 20 years', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 25),

            // Your schedule section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your schedule', style: TextStyle(fontSize: 22, color: Colors.teal)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScheduleScreen()),
                    );
                  },
                  child: Text('View All', style: TextStyle(fontSize: 15, color: Colors.teal[200])),
                ),
              ],
            ),
            SizedBox(height: 25),
            Container(
              height: 200, // Reduced height
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ScheduleCard(
                    doctorName: 'Dr. Nanu',
                    doctorTitle: 'Dentist',
                    date: 'Wednesday, 7 Aug 2024',
                    time: '11:00 AM - 12:00 PM',
                    appointmentType: 'online',
                    imagePath: 'images/file (7).png',
                  ),
                  SizedBox(width: 10),
                  ScheduleCard(
                    doctorName: 'Dr. Smith',
                    doctorTitle: 'Cardiologist',
                    date: 'Wednesday, 7 Aug 2024',
                    time: '11:00 AM - 12:00 PM',
                    appointmentType: 'online',
                    imagePath: 'images/file[1].png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Surf Doctors section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Surf Doctors', style: TextStyle(fontSize: 22, color: Colors.teal)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorsScreen()),
                    );
                  },
                  child: Text('View All', style: TextStyle(fontSize: 15, color: Colors.teal[200])),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 200,
              // Increased height
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: surfDoctors
                    .map((doctor) => SurfDoctorCard(
                  doctorName: doctor['doctorName'],
                  specialty: doctor['specialty'],
                  imagePath: doctor['imagePath'],
                ))
                    .toList(),
              ),
            ),

            SizedBox(height: 20),

            // Health tools and self-checks section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Health tools and self checks', style: TextStyle(fontSize: 22, color: Colors.teal)),
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 150, // Increased height
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: healthTools
                    .map((tool) => HealthToolCard(
                  icon: tool['icon'],
                  name: tool['name'],
                ))
                    .toList(),
              ),
            ),

            SizedBox(height: 20),

            // Medications section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Medications', style: TextStyle(fontSize: 22, color: Colors.teal)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicationsScreen()),
                    );
                  },
                  child: Text('View All', style: TextStyle(fontSize: 15, color: Colors.teal[200])),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 150, // Increased height
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: medications
                    .map((medication) => MedicationCard(
                  icon: medication['icon'],
                  name: medication['name'],
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthToolCard extends StatelessWidget {
  final IconData icon;
  final String name;

  const HealthToolCard({
    Key? key,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: 140, // Increased width
        height: 140, // Increased height
        decoration: BoxDecoration(
          color: Colors.teal[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white), // Increased icon size
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 16, // Increased font size
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Small font',
              style: TextStyle(
                fontSize: 12, // Increased font size
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final IconData icon;
  final String name;

  const MedicationCard({
    Key? key,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: 140, // Increased width
        height: 140, // Increased height
        decoration: BoxDecoration(
          color: Colors.teal[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white), // Increased icon size
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 16, // Increased font size
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Small font',
              style: TextStyle(
                fontSize: 12, // Increased font size
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const ResponsiveNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      child: GNav(
        gap: 8,
        activeColor: Colors.white,
        color: Colors.teal,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Colors.teal,
        tabs: [
          GButton(icon: FontAwesomeIcons.home, text: 'Home'),
          GButton(icon: FontAwesomeIcons.calendarAlt, text: 'Calendar'),
          GButton(icon: FontAwesomeIcons.book, text: 'Story'),
          GButton(icon: FontAwesomeIcons.cog, text: 'Settings'),
          GButton(icon: FontAwesomeIcons.music, text: 'Music'),
        ],
        selectedIndex: selectedIndex,
        onTabChange: onItemTapped,
      ),
    );
  }
}
