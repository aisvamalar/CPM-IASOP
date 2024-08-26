import 'package:flutter/material.dart';
import '../main.dart';
import 'appointment_payment_screen.dart';


void main() {
  runApp(MyApp());
}
class AppointmentVScreen extends StatefulWidget {
  @override
  _AppointmentVScreenState createState() => _AppointmentVScreenState();
}

class _AppointmentVScreenState extends State<AppointmentVScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0BB793),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF0BB793),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage('images/img_6.png'), // Replace with your asset image
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Deepak',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Cardio Specialist',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star_border, color: Colors.yellow),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(width: 4.0),
                              Text(
                                'Get location',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0), // Padding around the icon
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.tealAccent, Colors.teal],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle, // Circular background
                            ),
                            child: const Icon(Icons.house, color: Colors.white),
                          ),
                          const SizedBox(width: 16.0), // Space between icons
                          Container(
                            padding: const EdgeInsets.all(8.0), // Padding around the icon
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.tealAccent, Colors.teal],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle, // Circular background
                            ),
                            child: const Icon(Icons.chat, color: Colors.white),
                          ),
                          const SizedBox(width: 16.0), // Space between icons
                          Container(
                            padding: const EdgeInsets.all(8.0), // Padding around the icon
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.tealAccent, Colors.lightBlueAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle, // Circular background
                            ),
                            child: const Icon(Icons.video_camera_front_sharp, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Date Selection Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_getMonthName(selectedDate.month)} ${selectedDate.year}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Color(0xFF0BB793), // Header background color
                                onPrimary: Colors.white, // Header text color
                                onSurface: Colors.black, // Body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: Color(0xFF0BB793), // Button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Dates Row with Horizontal Scrolling
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildDateBox('Mon', '19'),
                    SizedBox(width: 8.0), // Add spacing between date boxes
                    _buildDateBox('Tue', '20', isSelected: true),
                    SizedBox(width: 8.0),
                    _buildDateBox('Wed', '21'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Thurs', '22'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Fri', '23'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Sat', '24'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Sun', '25'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Mon', '26'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Tue', '27'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Wed', '28'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Thurs', '29'),
                    SizedBox(width: 8.0),
                    _buildDateBox('Fri', '30'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 26.0),
            // Available Slots Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    'Available Slots',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0BB793), // Color theme
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            // Morning Session
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Morning',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeSlot('9:00 am'),
                      _buildTimeSlot('9:30 am', isSelected: true),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeSlot('10:30 am'),
                      _buildTimeSlot('11:00 am'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Evening Session
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Evening',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeSlot('5:00 pm'),
                      _buildTimeSlot('5:50 pm'),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeSlot('6:00 pm'),
                      _buildTimeSlot('6:50 pm'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0), // Space between slots and button
            // Go to Payment Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentPaymentScreen()),
                  );// Action to be performed on button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xFF0BB793), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                ),
                child: Text(
                  'Go to Payment',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0), // Extra space below the button
          ],
        ),
      ),
    );
  }

  Widget _buildDateBox(String day, String date, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF0BB793) : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            date,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time, {bool isSelected = false}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF0BB793) : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}