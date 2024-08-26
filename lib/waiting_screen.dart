import 'package:flutter/material.dart';
import 'package:iasop/screens/mes_screen.dart';

class WaitingScreen extends StatelessWidget {
  final List<Map<String, String>> appointments = [
    {
      'imagePath': 'images/file (9).png',
      'time': '9:00 AM',
      'disease': 'Flu Symptoms',
      'doctor': 'Dr. Alice Smith',
      'clinic': 'Downtown Clinic',
      'moreInfo': 'Patient is showing mild flu symptoms and needs rest.'
    },
    {
      'imagePath': 'images/file (10).png',
      'time': '10:30 AM',
      'disease': 'Back Pain',
      'doctor': 'Dr. Bob Johnson',
      'clinic': 'Westside Clinic',
      'moreInfo': 'Patient has been experiencing severe back pain for a week.'
    },
    {
      'imagePath': 'images/file (11).png',
      'time': '12:00 PM',
      'disease': 'Headache',
      'doctor': 'Dr. Carol Williams',
      'clinic': 'Eastside Clinic',
      'moreInfo': 'Patient suffers from chronic headaches and requires medication.'
    },
    {
      'imagePath': 'images/file (12).png',
      'time': '1:30 PM',
      'disease': 'Skin Rash',
      'doctor': 'Dr. David Brown',
      'clinic': 'North Clinic',
      'moreInfo': 'Patient has a rash that is spreading; needs immediate attention.'
    },
    {
      'imagePath': 'images/file (13).png',
      'time': '3:00 PM',
      'disease': 'Diabetes Checkup',
      'doctor': 'Dr. Emily Davis',
      'clinic': 'South Clinic',
      'moreInfo': 'Routine checkup to monitor diabetes levels.'
    },
    {
      'imagePath': 'images/file (14).png',
      'time': '4:30 PM',
      'disease': 'Allergy Test',
      'doctor': 'Dr. Frank Miller',
      'clinic': 'Central Clinic',
      'moreInfo': 'Patient is undergoing allergy testing for various substances.'
    },
    {
      'imagePath': 'images/file (15).png',
      'time': '6:00 PM',
      'disease': 'Follow-up',
      'doctor': 'Dr. Grace Wilson',
      'clinic': 'Main Street Clinic',
      'moreInfo': 'Follow-up visit to check the progress of the ongoing treatment.'
    },
  ];

  void _showPatientInfo(BuildContext context, String moreInfo, String doctor, String clinic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Patient Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(moreInfo),
              SizedBox(height: 4),
              Text('Doctor: $doctor', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Clinic: $clinic'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Appointments'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MesScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: appointments.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8, // Adjust height/width ratio of the containers
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showPatientInfo(
                          context,
                          appointments[index]['moreInfo'] ?? 'No additional information available',
                          appointments[index]['doctor'] ?? 'Unknown',
                          appointments[index]['clinic'] ?? 'Unknown',
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(appointments[index]['imagePath'] ?? 'images/default.png'),
                        radius: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      appointments[index]['time'] ?? 'No time specified',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      appointments[index]['disease'] ?? 'No disease specified',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MesScreen()),
                        );
                      },
                      child: Icon(
                        Icons.message,
                        color: Colors.teal,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WaitingScreen(),
    theme: ThemeData(
      useMaterial3: true, // Enables Material Design 3
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        primary: Colors.teal,
        onPrimary: Colors.white,
        secondary: Colors.tealAccent,
      ),
    ),
  ));
}
