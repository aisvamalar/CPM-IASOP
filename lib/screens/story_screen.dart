import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StoryScreen(),
    );
  }
}

class StoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Row(
          children: [

            SizedBox(width: 8),
            Text('Hello julie ',style: TextStyle(color:Colors.white),),
            Icon(Icons.waving_hand,color: Colors.white,),

          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_add,color:Colors.white,),
            iconSize: 34,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          buildPost(
            context,
            name: 'Dr. Smith',
            specialization: 'Cardiologist',
            timeAgo: '2 days ago',
            title: 'Your Rightful Health Screening',
            description:
            'Health screening checks for potential issues early, based on age, gender, and medical history.'
                '#we are here to save lives',
            imagePath: 'images/img_12.png',
          ),
          buildAlert(
            context,
            title: 'Flu Alert!',
            description:
            'There has been a significant increase in flu cases reported in your area. Please take the necessary precautions to protect yourself and others.',
          ),
          buildPost(
            context,
            name: 'Dr. Roshan',
            specialization: 'Dentist',
            timeAgo: '24 hours ago',
            title: 'QUALITY DENTAL CARE',
            description: 'Our Services\n• Braces\n• Dental Implants\n• Teeth Whitening',
            imagePath: 'images/img_13.png',
          ),
          buildPost(
            context,
            name: 'Dr. Roxy',
            specialization: 'Dermatologist',
            timeAgo: '10 hours ago',
            title: 'Facial Aesthetics',
            description: 'Enhance your beauty with our expert facial aesthetic services.',
            imagePath: 'images/img_10.png',
          ),
        ],
      ),
    );
  }

  Widget buildPost(BuildContext context,
      {required String name,
        required String specialization,
        required String timeAgo,
        required String title,
        required String description,
        required String imagePath}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.teal[100], // Light teal color
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('images/img_9.png'),
              ),
              title: Row(
                children: [
                  Text(name),
                  SizedBox(width: 4),
                  Icon(Icons.verified, color: Colors.blue, size: 20), // Verified symbol
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(specialization),
                  Text(timeAgo),
                ],
              ),
              trailing: Icon(Icons.more_vert), // Three dots for more options
            ),
            Image.asset(imagePath),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(description),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.comment),
                      SizedBox(width: 4),
                      Text('See Comments'),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAlert(BuildContext context,
      {required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.red,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Text('See what to do'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
