import 'package:flutter/material.dart';

import 'appointment_screen.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MalariaInfoScreen()));

class MalariaInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.red,
        title: Text('Malaria',style: TextStyle(color: Colors.white,),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            // Set the background image
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/img_46.png'), // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 120,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset('images/img_45.png', height: 150),
                  ),
                ),
                _buildSection('Symptoms', [
                  'Fever and flu-like illness',
                  'Chills',
                  'Headache, muscle aches, and tiredness',
                  'Nausea, vomiting, and diarrhea',
                  'Loss of appetite',
                  'Yellow skin or whites of the eyes',
                  'Sore throat, cough, and difficulty breathing',
                ]),
                _buildSection('Precautions', [
                  'Use mosquito repellent: Use an EPA-registered insect repellent that contains DEET, IR3535, or Icaridin on exposed skin. You can also apply repellent to clothing.',
                  'Wear protective clothing: Wear long-sleeved shirts, pants, and socks, and tuck in your shirt and pant legs.',
                  'Sleep under a mosquito net: Use a mosquito net, especially one treated with insecticide.',
                ]),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: Text('Consult a Doctor',style: TextStyle(color: Colors.white,)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppointmentScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.red[200],
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          color: Colors.red[50],
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) => _buildBulletPoint(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_right, color: Colors.red, size: 20),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

