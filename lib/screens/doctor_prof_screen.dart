import 'package:flutter/material.dart';


import 'package:iasop/screens/story_screen.dart';
// Correct the path as needed

import 'package:shimmer/shimmer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'd_home_screen.dart';









void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Profile',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: DoctorProfScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DoctorProfScreen extends StatefulWidget {
  @override
  _DoctorProfScreenState createState() => _DoctorProfScreenState();
}

class _DoctorProfScreenState extends State<DoctorProfScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _offsetAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DHomeScreen()),
        );
        break;
      case 1:
      //  Navigator.pushReplacement(
       //   context,
       //   MaterialPageRoute(builder: (context) => CalendarScreen()),
      //  );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StoryScreen()),
        );
        break;
      case 3:
        //Navigator.pushReplacement(
        //  context,
        //  MaterialPageRoute(builder: (context) => SettingsScreen()),
       // );
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        elevation: 0,
        title: Text('Doctor Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF04352F), Color(0xFF0B9B8A)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'images/img_18.png',
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.teal,
                    highlightColor: Colors.teal.shade100,
                    child: Column(
                      children: [
                        Text(
                          'Dr. Deepak',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                          ),
                        ),
                        Text(
                          'Cardiologist | Kovai Hospital',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal.shade500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.orange),
                            Text(
                              ' (0 reviews)',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal.shade500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProfileStat(
                              icon: Icons.group,
                              label: 'Followers',
                              value: '0',
                            ),
                            ProfileStat(
                              icon: Icons.bookmark,
                              label: 'Consultations',
                              value: '5k+',
                            ),
                            ProfileStat(
                              icon: Icons.calendar_today,
                              label: 'Experience',
                              value: '4+ years',
                            ),
                            ProfileStat(
                              icon: Icons.school,
                              label: 'Qualification',
                              value: 'MBBS, MD',
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ExpansionTile(
                          title: Text(
                            'About me',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade700,
                            ),
                          ),
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'I am Dr. Deepak, a dedicated cardiologist at Kovai Hospital. After earning my MS from the Royal College of London, I have focused my career on providing exceptional cardiovascular care. My passion lies in improving patient outcomes and advancing heart health through innovative techniques.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.teal.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DHomeScreen()),
                );
              },
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Text('CONTINUE...', style: TextStyle(color: Colors.white)),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ResponsiveNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileStat({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal, size: 30),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.teal.shade700,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
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
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: GNav(
          backgroundColor: Colors.teal,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.teal.shade700,
          gap: 8,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            onItemTapped(index);
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.calendar_today,
              text: 'Calendar',
            ),
            GButton(
              icon: Icons.article,
              text: 'Story',
            ),
            GButton(
              icon: Icons.music_note,
              text: 'Music',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

