import 'package:flutter/material.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:iasop/screens/patient_home_screen.dart';






void main() => runApp(MaterialApp(
  home: PatientProfileScreen(),
  debugShowCheckedModeBanner: false,
));

class PatientProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Patient Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarGlow(
                glowColor: Colors.teal,
                endRadius: 100.0,
                duration: Duration(seconds: 2),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('images/img_1.png'),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Julie',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              SizedBox(height: 16),
              buildPatientInfo(),
              SizedBox(height: 24),
              buildButtonsGrid(context),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PatientHomeScreen()),
                  ); // Handle Create action
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Create',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPatientInfo() {
    return Wrap(
      spacing: 20.0,
      runSpacing: 10.0,
      children: [
        buildInfoItem('Gender: Female'),
        buildInfoItem('Age: 25 Years'),
        buildInfoItem('Blood group: B(-)ve'),
        buildInfoItem('Height: 160 cm'),
        buildInfoItem('Weight: 68 kg'),
        buildInfoItem('Contact: 9465393829'),
      ],
    );
  }

  Widget buildInfoItem(String text) {
    return SizedBox(
      width: 150,
      child: Text(
        text,
        style: TextStyle(fontSize: 17, color: Colors.teal),
      ),
    );
  }

  Widget buildButtonsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // 2 columns
      shrinkWrap: true,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1, // Ensure aspect ratio is 1 to keep buttons square
      children: [
        buildGridButton(context, Icons.medical_services, 'Medication', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicationPage()),
          );
        }),
        buildGridButton(context, Icons.family_restroom, 'Family Disease', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FamilyDiseasePage()),
          );
        }),
        buildGridButton(context, Icons.science, 'Lab Results', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LabResultsPage()),
          );
        }),
        buildGridButton(context, Icons.medical_information, 'Health Insurance', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InsuranceDetails()),
          );
        }),
        buildGridButton(context, Icons.accessibility, 'ABHA', () {
          // Handle New Button 5 action
        }),
        buildGridButton(context, Icons.medical_information, 'Ailments', () {
          // Handle New Button 6 action
        }),
      ],
    );
  }



  Widget buildGridButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: ClayContainer(
        color: Colors.teal[200],
        depth: 50,
        height: 80, // Ensure height matches width for square buttons
        width: 100,
        borderRadius: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

// Medication Page
class MedicationPage extends StatelessWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prescription',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications button
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Handle menu button
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle New Drug button press
                    },
                    icon: const Icon(Icons.local_hospital, color: Colors.white),
                    label: const Text(
                      'New Drug',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle Add button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Search Drugs',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Current medication',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Clear All',
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  buildMedicationItem('Advil', 'Ibuprofen Tablets, 200 mg'),
                  buildMedicationItem('Tylenol', 'Acetaminophen Tablets, 600 mg'),
                  buildMedicationItem('Benadryl', 'Diphenhydramine Tablets, 25 mg'),
                  buildMedicationItem('Oscillococcinum', 'Oscillococcinum Tablets, 200 mg'),
                  buildMedicationItem('Advil', 'Ibuprofen Tablets, 200 mg'),
                  buildMedicationItem('Benadryl', 'Diphenhydramine Tablets, 25 mg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMedicationItem(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.local_hospital, color: Colors.teal),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: TextButton(
        onPressed: () {
          // Handle prescribe action
        },
        child: const Text('Info'),
        style: TextButton.styleFrom(
          foregroundColor: Colors.teal,
        ),
      ),
    );
  }
}

// Family Disease Page
class FamilyDiseasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Disease Information', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Handle "New Entry" action
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('New Entry', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Diseases',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildDiseaseItem('Diabetes Type 2'),
                  buildDiseaseItem('Hypertension'),
                  buildDiseaseItem('Coronary Artery Disease'),
                  buildDiseaseItem('Breast Cancer'),
                  buildDiseaseItem('Asthma'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget buildDiseaseItem(String diseaseName) {
    return ListTile(
      leading: Icon(Icons.local_hospital, color: Colors.teal),
      title: Text(diseaseName),
      trailing: TextButton(
        onPressed: () {
          // Handle "More Info" action
        },
        child: Text(
          'More Info',
          style: TextStyle(color: Colors.teal),
        ),
      ),
    );
  }
}

// Lab Results Page
class LabResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        title: const Text(
          'Lab Results',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Handle Scan Your Report action
              },
              icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
              label: const Text(
                'Scan Your Report',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildUploadButton(
                    context,
                    icon: Icons.file_upload,
                    label: 'Upload Doc',
                    onPressed: () {
                      // Handle Upload Doc action
                    },
                  ),
                  const SizedBox(width: 16), // Space between buttons
                  buildUploadButton(
                    context,
                    icon: Icons.photo_camera,
                    label: 'Upload Photo',
                    onPressed: () {
                      // Handle Upload Photo action
                    },
                  ),
                  const SizedBox(width: 16), // Space between buttons
                  buildUploadButton(
                    context,
                    icon: Icons.videocam,
                    label: 'Upload Video',
                    onPressed: () {
                      // Handle Upload Video action
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  buildTestItem(context, 'Blood Test'),
                  buildTestItem(context, 'Urine Test'),
                  buildTestItem(context, 'MRI'),
                  buildTestItem(context, 'CT Scan'),
                  buildTestItem(context, 'ECG'),
                  buildTestItem(context, 'EEG'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTestItem(BuildContext context, String testName) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.science, color: Colors.teal),
        title: Text(testName, style: const TextStyle(fontSize: 18)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Handle delete action
          },
        ),
      ),
    );
  }

  Widget buildUploadButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        minimumSize: Size(110, 50),
      ),
    );
  }
}

// Insurance Details Page
class InsuranceDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        title: const Text(
          'Insurance Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInsuranceInfo(context, 'Provider:', 'ABC Insurance Co.'),
            buildInsuranceInfo(context, 'Policy Number:', '1234567890'),
            buildInsuranceInfo(context, 'Coverage Amount:', '\$500,000'),
            buildInsuranceInfo(context, 'Expiry Date:', '12/31/2025'),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Handle Update Insurance action
              },
              icon: Icon(Icons.edit, color: Colors.white),
              label: Text(
                'Update Insurance',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInsuranceInfo(BuildContext context, String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.info_outline, color: Colors.teal),
        title: Text(label, style: TextStyle(fontSize: 16)),
        subtitle: Text(value, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
