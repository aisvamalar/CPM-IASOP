import 'package:flutter/material.dart';

class MedicationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample list of medications
    final List<String> medications = [
      'Avil',
      'Herbal Tea',
      'Vitamin C',
      'Paracetamol',
      'Ibuprofen',
      'Antibiotics',
      'Cough Syrup',
      'Antacids',
      'Antiseptic Cream',
      'Bandages',
      'Inhaler',
      'Thermometer',
      'Eye Drops',
    ];

    // Correct icon names for each medication
    final List<IconData> medicationIcons = [
      Icons.local_hospital,   // Avil (antihistamine)
      Icons.local_cafe,       // Herbal Tea
      Icons.local_florist,    // Vitamin C
      Icons.local_pharmacy,   // Paracetamol
      Icons.healing,          // Ibuprofen
      Icons.medical_services, // Antibiotics
      Icons.local_drink,      // Cough Syrup
      Icons.add_box,          // Antacids
      Icons.healing,          // Antiseptic Cream
      Icons.personal_injury,  // Bandages
      Icons.air,              // Inhaler
      Icons.thermostat,       // Thermometer
      Icons.remove_red_eye    // Eye Drops
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('All Medications'),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: medications.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  medicationIcons[index],
                  color: Colors.white,
                ),
              ),
              title: Text(medications[index]),
            );
          },
        ),
      ),
    );
  }
}
