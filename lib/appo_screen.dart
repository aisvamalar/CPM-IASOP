import 'package:flutter/material.dart';
import 'package:iasop/screens/d_home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: AppoScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class AppoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF04352F), // Set AppBar color to #04352F
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate back to DHomeScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DHomeScreen()),
            );
          },
        ),
        title: Text('Patient Appointments', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Container(
            height: 200, // Adjust height of the container as needed
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF04352F), Color(0xFF0B9B8A)], // Gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft, // Fix the image at the bottom left of the container
                  child: Image.asset(
                    'images/img_18.png',

                    height: 180,
                    // Increase the image height
                  ),
                ),
                Positioned(
                  left: 180, // Adjust this value to position the text properly
                  top: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Deepak',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Text(
                        'Cardio Specialist',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.person, size: 50, color: Colors.teal),
                            SizedBox(height: 5),
                            Text('Patient Details', style: TextStyle(color: Colors.teal)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.calendar_today, size: 50, color: Colors.teal),
                            SizedBox(height: 5),
                            Text('Appointment', style: TextStyle(color: Colors.teal)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: PatientList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientList extends StatelessWidget {
  final List<Patient> patients = [
    Patient(name: 'Ram', age: 27, contact: '9257178928', time: '5:10 PM', status: 'Arrived'),
    Patient(name: 'Devi', age: 24, contact: '8253778928', time: '3:00 PM', status: 'Arrived'),
    Patient(name: 'Priya', age: 37, contact: '9208789473', time: '10:00 AM', status: 'Not Arrived'),
    Patient(name: 'Kumar', age: 42, contact: '9485293620', time: '6:00 PM', status: 'Not Arrived'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return PatientCard(patient: patients[index]);
      },
    );
  }
}

class PatientCard extends StatelessWidget {
  final Patient patient;

  PatientCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Patient name: ${patient.name}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('Age: ${patient.age}'),
                Text('Contact: ${patient.contact}'),
              ],
            ),
            Column(
              children: [
                Text(patient.time, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: patient.status == 'Arrived' ? Colors.teal[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    patient.status,
                    style: TextStyle(
                      color: patient.status == 'Arrived' ? Colors.teal : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Patient {
  final String name;
  final int age;
  final String contact;
  final String time;
  final String status;

  Patient({required this.name, required this.age, required this.contact, required this.time, required this.status});
}