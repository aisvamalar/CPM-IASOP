import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'consultation_screen.dart';  // Ensure this file exists and is imported

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Info App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: DocInfoScreen(),
    );
  }
}

class DocInfoScreen extends StatefulWidget {
  @override
  _DocInfoScreenState createState() => _DocInfoScreenState();
}

class _DocInfoScreenState extends State<DocInfoScreen> {
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  String? qrCodeResult;
  QRViewController? qrViewController;

  // Firebase Realtime Database Reference
  final databaseReference = FirebaseDatabase.instance.ref();

  // Method to save doctor information to Firebase
  Future<void> saveDoctorInfo() async {
    String doctorName = _doctorNameController.text;
    String qualification = _qualificationController.text;
    String aboutMe = _aboutMeController.text;

    if (doctorName.isNotEmpty && qualification.isNotEmpty && qrCodeResult != null) {
      try {
        await databaseReference.child("doctors").push().set({
          'doctorName': doctorName,
          'qualification': qualification,
          'qrCodeUrl': qrCodeResult,
          'aboutMe': aboutMe,
        });

        // Debugging statement to check navigation
        print("Navigating to ConsultationScreen");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ConsultationScreen()),
        );
      } catch (e) {
        // Log errors
        print("Error saving doctor info: $e");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and scan a QR code')),
      );
    }
  }

  @override
  void dispose() {
    _doctorNameController.dispose();
    _qualificationController.dispose();
    _aboutMeController.dispose();
    qrViewController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrViewController = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrCodeResult = scanData.code;
        qrViewController?.pauseCamera(); // Pause scanning after QR is found
      });
      Navigator.pop(context); // Close the QR view screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF04352F), Color(0xFF0B9B8A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      AvatarGlow(
                        glowColor: Colors.white38,
                        endRadius: 90.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('images/img_6.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  controller: _doctorNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.teal),
                    labelText: 'Doctor name',
                    labelStyle: TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  controller: _qualificationController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.school, color: Colors.teal),
                    labelText: 'Qualification',
                    labelStyle: TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRViewScreen(onScanned: (result) {
                          setState(() {
                            qrCodeResult = result;
                          });
                        }),
                      ),
                    );
                  },
                  icon: Icon(Icons.qr_code, color: Colors.white),
                  label: Text(qrCodeResult != null ? "Scanned" : "Scan Medical Certificate"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  controller: _aboutMeController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'About Me',
                    labelStyle: TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: saveDoctorInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Text('Continue', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QRViewScreen extends StatefulWidget {
  final Function(String) onScanned;

  QRViewScreen({required this.onScanned});

  @override
  _QRViewScreenState createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      controller = qrController;
    });

    qrController.scannedDataStream.listen((scanData) {
      widget.onScanned(scanData.code!);
      controller?.pauseCamera(); // Pause scanning
      Navigator.pop(context); // Close the QR view screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR Code")),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}