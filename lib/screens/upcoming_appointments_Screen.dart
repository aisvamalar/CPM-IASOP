import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UpcomingAppointmentsScreen(),
    );
  }
}

class UpcomingAppointmentsScreen extends StatelessWidget {
  final List<Appointment> appointments = [
    Appointment(
      patientName: 'John Doe',
      appointmentDate: DateTime.now().add(Duration(days: 2)),
      time: '10:00 AM',
      reason: 'Regular Checkup',
      contact: '123-456-7890',
      medicalHistory: 'No known allergies',
      photoPath: 'images/file[1].png',
    ),
    Appointment(
      patientName: 'Jane Smith',
      appointmentDate: DateTime.now().add(Duration(days: 3)),
      time: '11:30 AM',
      reason: 'Dental Cleaning',
      contact: '987-654-3210',
      medicalHistory: 'Sensitive teeth',
      photoPath: 'images/file_(2)[1].png',
    ),
    Appointment(
      patientName: 'Alice Johnson',
      appointmentDate: DateTime.now().add(Duration(days: 5)),
      time: '02:00 PM',
      reason: 'Follow-up',
      contact: '555-555-5555',
      medicalHistory: 'Hypertension',
      photoPath: 'images/file_(3)[1].png',
    ),
    Appointment(
      patientName: 'Michael Brown',
      appointmentDate: DateTime.now().add(Duration(days: 6)),
      time: '09:00 AM',
      reason: 'Routine Checkup',
      contact: '666-777-8888',
      medicalHistory: 'Diabetes',
      photoPath: 'images/file_(4)[1].png',
    ),
    Appointment(
      patientName: 'Emily Davis',
      appointmentDate: DateTime.now().add(Duration(days: 7)),
      time: '01:00 PM',
      reason: 'Eye Examination',
      contact: '444-555-6666',
      medicalHistory: 'No known issues',
      photoPath: 'images/file (5).png',
    ),
    Appointment(
      patientName: 'Daniel Wilson',
      appointmentDate: DateTime.now().add(Duration(days: 8)),
      time: '03:00 PM',
      reason: 'Physical Therapy',
      contact: '333-444-5555',
      medicalHistory: 'Back pain',
      photoPath: 'images/file (6).png',
    ),
    Appointment(
      patientName: 'Sophia Miller',
      appointmentDate: DateTime.now().add(Duration(days: 9)),
      time: '10:30 AM',
      reason: 'Cardiology Checkup',
      contact: '222-333-4444',
      medicalHistory: 'Heart condition',
      photoPath: 'images/file (7).png',
    ),
    // Add more appointments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Upcoming Appointments'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AnimatedAppointmentCard(appointment: appointment);
        },
      ),
    );
  }
}

class AnimatedAppointmentCard extends StatefulWidget {
  final Appointment appointment;

  const AnimatedAppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  _AnimatedAppointmentCardState createState() => _AnimatedAppointmentCardState();
}

class _AnimatedAppointmentCardState extends State<AnimatedAppointmentCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slideAnimation = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              _isExpanded ? _controller.forward() : _controller.reverse();
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.appointment.patientName,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Date: ${DateFormat.yMMMd().format(widget.appointment.appointmentDate)}'),
                      Text('Time: ${widget.appointment.time}'),
                      Text('Reason: ${widget.appointment.reason}'),
                      if (_isExpanded) ...[
                        SizedBox(height: 10),
                        Divider(),
                        Text('Contact: ${widget.appointment.contact}'),
                        Text('Medical History: ${widget.appointment.medicalHistory}'),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 10),
                AnimatedOpacity(
                  opacity: _isExpanded ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: Image.asset(
                    widget.appointment.photoPath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Appointment {
  final String patientName;
  final DateTime appointmentDate;
  final String time;
  final String reason;
  final String contact;
  final String medicalHistory;
  final String photoPath;

  Appointment({
    required this.patientName,
    required this.appointmentDate,
    required this.time,
    required this.reason,
    required this.contact,
    required this.medicalHistory,
    required this.photoPath,
  });
}
