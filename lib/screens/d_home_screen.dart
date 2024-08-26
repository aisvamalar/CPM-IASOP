import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:iasop/screens/qa_screen.dart';
import 'package:iasop/screens/schedule_screen.dart';
import 'package:iasop/screens/upcoming_appointments_Screen.dart';

import '../appo_screen.dart';
import '../waiting_screen.dart';
import 'add_screen.dart';
import 'dsettins_screen.dart';
import 'myprofile_screen.dart'; // Import the MyProfileScreen
 // Import the AppoScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DHomeScreen(),
      routes: {
        '/home': (context) => DHomeScreen(),
        '/qa': (context) => QAScreen(),
        '/add': (context) => AddScreen(),
        'upcoming appointments': (context) => UpcomingAppointmentsScreen(),
        '/dsettins': (context) => DSettinsScreen(),
        '/myprofile': (context) => MyProfileScreen(),
        '/appo': (context) => AppoScreen(), // Add route for AppoScreen
      },
    );
  }
}

class DHomeScreen extends StatefulWidget {
  @override
  _DHomeScreenState createState() => _DHomeScreenState();
}

class _DHomeScreenState extends State<DHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation based on selected index
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/dhome');
          break;
        case 1:
          Navigator.pushNamed(context, '/qa');
          break;
        case 2:
          Navigator.pushNamed(context, '/add');
          break;
        case 3:
          Navigator.pushNamed(context, '/upcoming appointments');
          break;
        case 4:
          Navigator.pushNamed(context, '/dsettins');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/myprofile');
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/img_6.png'),
                    radius: 20,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Hello Doc!!👋',
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.teal),
                onPressed: () {
                  Navigator.pushNamed(context, '/appo');
                },
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.teal,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your schedule',
                      style: TextStyle(fontSize: 22, color: Colors.teal)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>WaitingScreen()),
                      );
                    },
                    child: Text('View All',
                        style: TextStyle(
                            fontSize: 15, color: Colors.teal[200])),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AnimatedScheduleCard(
                      name: 'Julie',
                      appointmentType: 'Direct',
                      time: '10:00AM-11:00AM',
                      imagePath: 'images/img_1.png',
                    ),
                    SizedBox(width: 15),
                    AnimatedScheduleCard(
                      name: 'Jenny',
                      appointmentType: 'Virtual',
                      time: '11:30AM-12:00PM',
                      imagePath: 'images/img_26.png',
                    ),
                    SizedBox(width: 15),
                    AnimatedScheduleCard(
                      name: 'Paul',
                      appointmentType: 'Direct',
                      time: '12:30PM-01:30PM',
                      imagePath: 'images/img_1.png',
                    ),
                    SizedBox(width: 15),
                    AnimatedScheduleCard(
                      name: 'Emma',
                      appointmentType: 'Virtual',
                      time: '02:00PM-03:00PM',
                      imagePath: 'images/img_26.png',
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                AnimatedContentCard(
                  doctorName: 'Dr. Smith',
                  timeAgo: '2 days ago',
                  content: 'Your Rightful Health Screening',
                  circleImagePath: 'images/img_6.png',
                  contentImagePath: 'images/img_4.png',
                  comments: '25',
                  likes: '100', // Added likes count
                  shares: '10', // Added shares count
                  description: 'This is a description of the health screening conducted by Dr. Smith.', // Added description
                ),
                AnimatedContentCard(
                  doctorName: 'Dr. Roshan',
                  timeAgo: '24 hours ago',
                  content: 'Quality Dental Care',
                  circleImagePath: 'images/img_31.png',
                  contentImagePath: 'images/img_5.png',
                  comments: '45',
                  likes: '150', // Added likes count
                  shares: '20', // Added shares count
                  description: 'An insightful post about the importance of dental care by Dr. Roshan.', // Added description
                ),
                // Add more AnimatedContentCard widgets as needed...
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.question_answer, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.calendar_today, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        color: Colors.teal,
        buttonBackgroundColor: Colors.teal,
        backgroundColor: Colors.grey[200]!,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: _onItemTapped,
      ),
    );
  }
}

class AnimatedScheduleCard extends StatefulWidget {
  final String name;
  final String appointmentType;
  final String time;
  final String imagePath;

  const AnimatedScheduleCard({
    Key? key,
    required this.name,
    required this.appointmentType,
    required this.time,
    required this.imagePath,
  }) : super(key: key);

  @override
  _AnimatedScheduleCardState createState() => _AnimatedScheduleCardState();
}

class _AnimatedScheduleCardState extends State<AnimatedScheduleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: EdgeInsets.all(15),
        width: 300,
        decoration: BoxDecoration(
          color: Colors.teal[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.imagePath),
              radius: 30,
            ),
            SizedBox(height: 10),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.appointmentType,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.time,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedContentCard extends StatefulWidget {
  final String doctorName;
  final String timeAgo;
  final String content;
  final String circleImagePath;
  final String contentImagePath;
  final String comments;
  final String likes; // Added likes
  final String shares; // Added shares
  final String description; // Added description

  const AnimatedContentCard({
    Key? key,
    required this.doctorName,
    required this.timeAgo,
    required this.content,
    required this.circleImagePath,
    required this.contentImagePath,
    required this.comments,
    required this.likes, // Added likes
    required this.shares, // Added shares
    required this.description, // Added description
  }) : super(key: key);

  @override
  _AnimatedContentCardState createState() => _AnimatedContentCardState();
}

class _AnimatedContentCardState extends State<AnimatedContentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  bool isLiked = false;
  int likesCount = 0;
  int sharesCount = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();

    likesCount = int.parse(widget.likes);
    sharesCount = int.parse(widget.shares);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likesCount--;
      } else {
        likesCount++;
      }
      isLiked = !isLiked;
    });
  }

  void incrementShares() {
    setState(() {
      sharesCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.teal[50],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(widget.circleImagePath),
              ),
              title: Text(widget.doctorName,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(widget.timeAgo),
              trailing: Icon(Icons.more_vert),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(widget.content,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(widget.contentImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.description, style: TextStyle(fontSize: 10)), // Display description
                  SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: toggleLike,
                      ),
                      Text('$likesCount likes', style: TextStyle(fontSize: 10)),
                      SizedBox(width: 15),
                      IconButton(
                        icon: Icon(Icons.comment, color: Colors.grey),
                        onPressed: () {
                          // Handle comments icon tap
                        },
                      ),
                      Text('${widget.comments} comments',
                          style: TextStyle(fontSize: 10)),
                      SizedBox(width: 15),
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.grey),
                        onPressed: incrementShares,
                      ),
                      Text('$sharesCount shares', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

