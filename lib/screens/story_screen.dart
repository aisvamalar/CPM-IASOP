import 'package:flutter/material.dart';
import 'package:iasop/screens/malaria_info_screen.dart';
import 'package:iasop/services/api_service.dart';

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
            Text('Hello Julie ', style: TextStyle(color: Colors.white)),
            Icon(Icons.waving_hand, color: Colors.white),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_add, color: Colors.white),
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
            'Health screening checks for potential issues early, based on age, gender, and medical history. #we are here to save lives',
            imagePath: 'images/img_12.png',
          ),
          buildAlertWithApiIntegration(
            context,
            title: 'Outbreak Alert!',
          ),
          buildPost(
            context,
            name: 'Dr. Roshan',
            specialization: 'Dentist',
            timeAgo: '24 hours ago',
            title: 'QUALITY DENTAL CARE',
            description:
            'Our Services\n• Braces\n• Dental Implants\n• Teeth Whitening',
            imagePath: 'images/img_13.png',
          ),
          buildPost(
            context,
            name: 'Dr. Roxy',
            specialization: 'Dermatologist',
            timeAgo: '10 hours ago',
            title: 'Facial Aesthetics',
            description:
            'Enhance your beauty with our expert facial aesthetic services.',
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
        color: Colors.teal[100],
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
                  Icon(Icons.verified, color: Colors.blue, size: 20),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(specialization),
                  Text(timeAgo),
                ],
              ),
              trailing: Icon(Icons.more_vert),
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
                      Text('See Comments',
                          style: TextStyle(color: Colors.white)),
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

  Widget buildAlertWithApiIntegration(BuildContext context,
      {required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.red,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ApiIntegration(title: title),
      ),
    );
  }
}

class ApiIntegration extends StatefulWidget {
  final String title;

  ApiIntegration({required this.title});

  @override
  _ApiIntegrationState createState() => _ApiIntegrationState();
}

class _ApiIntegrationState extends State<ApiIntegration> {
  String predictionMessage = 'Click to get prediction';
  String city = 'Chennai'; // Default city
  late ApiService apiService;
  bool isLoading = false;
  String error = '';
  Map<String, dynamic>? prediction;

  @override
  void initState() {
    super.initState();
    // Initialize the ApiService with your Flask server's URL
    apiService = ApiService('http://192.168.23.56:5000');
  }

  void fetchPrediction() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      // Fetch the prediction from the API
      final result = await apiService.getPrediction(city);
      setState(() {
        prediction = result;
        predictionMessage = result['message']; // Display the message from the API
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        predictionMessage = 'Error fetching prediction';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            predictionMessage,
            style: TextStyle(color: Colors.white),
          ),
          if (error.isNotEmpty)
            Text('Error: $error', style: TextStyle(color: Colors.red)),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton(
                  onPressed: fetchPrediction,
                  child: Text(
                    'Get Prediction',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(height: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MalariaInfoScreen()),
                    );// Action for 'Learn More' button
                    print('Learn More clicked');
                  },
                  child: Text(
                    'Learn More',
                    style: TextStyle(color: Colors.red),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color of the button
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}