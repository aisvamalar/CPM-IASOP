import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'consultation_screen.dart';  // Ensure this file exists and is imported
import 'dart:io'; // Import for File handling

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
  final TextEditingController _workPlaceController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  String? qrCodeResult;
  QRViewController? qrViewController;
  XFile? _profileImage; // Variable to store the picked image
  String? _profileImageUrl; // Variable to store the profile image URL

  // Firebase Realtime Database Reference
  final databaseReference = FirebaseDatabase.instance.ref();
  final storageReference = FirebaseStorage.instance.ref();

  final picker = ImagePicker();

  // Method to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedFile;
    });
    if (pickedFile != null) {
      await _uploadProfileImage(pickedFile);
    }
  }

  // Method to upload image to Firebase Storage
  Future<void> _uploadProfileImage(XFile image) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference ref = storageReference.child('profile_images/$fileName');
      final UploadTask uploadTask = ref.putFile(File(image.path));

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _profileImageUrl = downloadUrl;
      });
    } catch (e) {
      print("Error uploading profile image: $e");
    }
  }

  // Method to save doctor information to Firebase
  Future<void> saveDoctorInfo() async {
    String doctorName = _doctorNameController.text;
    String qualification = _qualificationController.text;
    String workPlace = _workPlaceController.text;
    String experience = _experienceController.text;
    String aboutMe = _aboutMeController.text;

    if (doctorName.isNotEmpty && qualification.isNotEmpty && workPlace.isNotEmpty && experience.isNotEmpty && qrCodeResult != null) {
      try {
        await databaseReference.child("doctors").push().set({
          'doctorName': doctorName,
          'qualification': qualification,
          'workPlace': workPlace,
          'experience': experience,
          'qrCodeUrl': qrCodeResult,
          'profileImageUrl': _profileImageUrl, // Save the profile image URL
          'aboutMe': aboutMe,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ConsultationScreen()),
        );
      } catch (e) {
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
    _workPlaceController.dispose();
    _experienceController.dispose();
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
                SizedBox(height: 20),
                AvatarGlow(
                  glowColor: Colors.white38,
                  endRadius: 90.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _profileImage != null
                            ? FileImage(File(_profileImage!.path))
                            : _profileImageUrl != null
                            ? NetworkImage(_profileImageUrl!) as ImageProvider
                            : AssetImage('images/add profile.png') as ImageProvider,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Doctor Name Field
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

                // Qualification Field
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

                // Work Place Field
                TextField(
                  controller: _workPlaceController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_city, color: Colors.teal),
                    labelText: 'Workplace',
                    labelStyle: TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Years of Experience Field
                TextField(
                  controller: _experienceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.timeline, color: Colors.teal),
                    labelText: 'Years of Experience',
                    labelStyle: TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // QR Code Button
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
                  label: Text(qrCodeResult != null ? "Scanned" : "Scan Medical Certificate", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // About Me Field
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

                // Continue Button
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