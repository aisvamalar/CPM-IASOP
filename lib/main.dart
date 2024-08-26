import 'package:flutter/material.dart';
import 'package:iasop/screens/add_screen.dart';
import 'package:iasop/screens/appoin_screen.dart';




import 'package:iasop/screens/appointmentM_screen.dart';
import 'package:iasop/screens/appointmentV_screen.dart';
import 'package:iasop/screens/appointment_payment_screen.dart';
import 'package:iasop/screens/appointment_screen.dart';
import 'package:iasop/screens/consultation_screen.dart';

import 'package:iasop/screens/d_home_screen.dart';
import 'package:iasop/screens/doc_profile_screen.dart';

import 'package:iasop/screens/docinfo_screen.dart';
import 'package:iasop/screens/doctor_prof_screen.dart';
import 'package:iasop/screens/doctor_profile_screen.dart';
import 'package:iasop/screens/doctor_register_screen.dart';
import 'package:iasop/screens/doctors_screen.dart';
import 'package:iasop/screens/dsettins_screen.dart';
import 'package:iasop/screens/mes_screen.dart';
import 'package:iasop/screens/message_screen.dart';
import 'package:iasop/screens/music_screen.dart';
import 'package:iasop/screens/patient_home_screen.dart';

import 'package:iasop/screens/login_screen.dart';
import 'package:iasop/screens/medication_screen.dart';
import 'package:iasop/screens/music_therapy_screen.dart';
import 'package:iasop/screens/myprofile_screen.dart';
import 'package:iasop/screens/patient_home_screen.dart';
import 'package:iasop/screens/patient_profile_screen.dart';
import 'package:iasop/screens/patient_register_screen.dart';

import 'package:iasop/screens/pcalendar_screen.dart';
import 'package:iasop/screens/psettings_screen.dart';
import 'package:iasop/screens/qa_screen.dart';

import 'package:iasop/screens/select_field_screen.dart';
import 'package:iasop/screens/slot_screen.dart';

import 'package:iasop/screens/splash_screen.dart';
import 'package:iasop/screens/story_screen.dart';
import 'package:iasop/screens/upcoming_appointments_Screen.dart';
import 'package:iasop/screens/vid_screen.dart';
import 'package:iasop/screens/video_screen.dart';
import 'package:iasop/waiting_screen.dart';

import 'appo_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthcare App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Initial splash screen
        '/login': (context) => LoginScreen(),


        '/selectfield': (context) => SelectFieldScreen(),
        '/appointmentpayment': (context) => AppointmentPaymentScreen(),
        '/doctorregister': (context) => DoctorRegisterScreen(),
        '/doctorprof': (context) => DoctorProfScreen(),
        '/dhome': (context) => DHomeScreen(),
        '/myprofile': (context) => MyProfileScreen(),
        '/upcoming appointments': (context) => UpcomingAppointmentsScreen(),
        '/qa': (context) => QAScreen(),
        '/dsettins': (context) => DSettinsScreen(),
        '/docinfo': (context) => DocInfoScreen(),
        '/consultation': (context) => ConsultationScreen(),
        '/slot': (context) => SlotScreen(),
        '/add': (context) => AddScreen(),
        '/message': (context) => MessageScreen(),
        '/mes': (context) => MesScreen(),
        '/waiting': (context) => WaitingScreen(),
        '/docprofile': (context) => DocProfileScreen(),

        '/patientregister': (context) => PatientRegisterScreen(),
        '/appo': (context) => AppoScreen(),

        '/patienthome': (context) => PatientHomeScreen(),
        '/pcalendar': (context) => PCalendarScreen(),
        '/doctor': (context) => DoctorsScreen(),
        '/musictherapy': (context) => MusicTherapyScreen(),
        // Calendar screen
        '/story': (context) => StoryScreen(), // Story screen
        '/psettings': (context) => PSettingsScreen(),
        '/music': (context) => MusicScreen(),
        // Settings screen
        '/medications': (context) => MedicationsScreen(),
        '/appointment': (context) => AppointmentScreen(),

        '/video': (context) => VideoScreen(),
        '/vid': (context) => VidScreen(),
        '/appointmentM': (context) => AppointmentMScreen(),
        '/appoin': (context) => AppoinScreen(),
        '/appointmentV': (context) => AppointmentVScreen(),




         // Registration screen

        // Home screen

        // Medications screen
      },
    );
  }
}
