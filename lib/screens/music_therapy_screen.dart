import 'package:flutter/material.dart';
import 'dart:math';

import 'music_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MusicTherapyScreen(),
    );
  }
}

// Enum for Animation Type
enum AnimationType { flipX, flipY }

// Custom Animated List Item
class AnimatedListItem extends StatelessWidget {
  final int index;
  final int length;
  final AnimationController aniController;
  final AnimationType animationType;
  final Widget child;
  final VoidCallback onTap;

  AnimatedListItem({
    required this.index,
    required this.length,
    required this.aniController,
    required this.animationType,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: aniController,
        curve: Interval(
          (1 / length) * index,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final isFront = animation.value <= 0.5;
          final double rotationAngle = animation.value * pi;

          Matrix4 transform = Matrix4.identity();

          if (animationType == AnimationType.flipX) {
            transform = Matrix4.rotationX(rotationAngle);
          } else if (animationType == AnimationType.flipY) {
            transform = Matrix4.rotationY(rotationAngle);
          }

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isFront
                ? child
                : Transform(
              transform: animationType == AnimationType.flipX
                  ? Matrix4.rotationX(pi)
                  : Matrix4.rotationY(pi),
              alignment: Alignment.center,
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}

// Main Screen with ListView of Animated Items
class MusicTherapyScreen extends StatefulWidget {
  @override
  _MusicTherapyScreenState createState() => _MusicTherapyScreenState();
}

class _MusicTherapyScreenState extends State<MusicTherapyScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, String>> list = [
    {'imageUrl': 'images/img_17.png', 'title': 'Sleep', 'subtitle': 'Soothing, calming music'},
    {'imageUrl': 'images/img_19.png', 'title': 'Concentrate', 'subtitle': 'Concentration, good sleep, reduce panic'},
    {'imageUrl': 'images/img_20.png', 'title': 'Calm', 'subtitle': 'Relax, Calming down'},
    {'imageUrl': 'images/img_21.png', 'title': 'Stress', 'subtitle': 'Self-tempo music, mood boost'},
    {'imageUrl': 'images/img_22.png', 'title': 'Meditation', 'subtitle': 'Creativity memory compassion'},
    {'imageUrl': 'images/img_23.png', 'title': 'Salfeggio frequencies', 'subtitle': 'Meditation Chakra'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToDetailScreen(BuildContext context, String imageUrl, String title, String subtitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          imageUrl: imageUrl,
          title: title,
          subtitle: subtitle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Musical Therapy',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return AnimatedListItem(
            index: index,
            length: list.length,
            aniController: _animationController,
            animationType: AnimationType.flipX,
            child: MeditationCard(
              imageUrl: list[index]['imageUrl']!,
              title: list[index]['title']!,
              subtitle: list[index]['subtitle']!,
            ),
            onTap: () => _navigateToDetailScreen(
              context,
              list[index]['imageUrl']!,
              list[index]['title']!,
              list[index]['subtitle']!,
            ),
          );
        },
      ),
    );
  }
}

// Card Widget for Each Item
// Card Widget for Each Item
class MeditationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  MeditationCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Check if the "Calm" card is tapped
        if (title == 'Calm') {
          // Navigate to MusicScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MusicScreen()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Detail Screen
class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  DetailScreen({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
