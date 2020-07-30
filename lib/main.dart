import 'package:flutter/material.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/appointments.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/check_history.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/d_edit_profile.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/get_patient.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/write_follow_up.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/doc_home_page.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_edit_history.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_edit_profile.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_follow_up.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_history.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_home_page.dart';
import 'package:medicalhelper/screens/Reg&Log/reg_doc.dart';
import 'package:medicalhelper/screens/Reg&Log/reg_user.dart';
import 'package:medicalhelper/screens/Reg&Log/login_screen.dart';
import 'package:medicalhelper/screens/Reg&Log/registration_screen.dart';
import 'package:medicalhelper/screens/Reg&Log/welcome_screen.dart';
import 'screens/Search/ui.dart';

void main() => runApp(MainProgram());

class MainProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        RegUser.id : (context) => RegUser(),
        RegDoc.id : (context) => RegDoc(),
        HomePage.id : (context) => HomePage(),
        DocHomePage.id : (context) => DocHomePage(),
        History.id : (context) => History(),
        EditProfile.id : (context) => EditProfile(),
        EditHistory.id : (context) => EditHistory(),
        DocEditProfile.id : (context) => DocEditProfile(),
        GetPatient.id : (context) => GetPatient(),
        CheckHistory.id : (context) => CheckHistory(),
        WriteFollowUp.id : (context) => WriteFollowUp(),
        Appointments.id : (context) => Appointments(),
        FollowUp.id : (context) => FollowUp(),
        home.id : (context) => home(),
      },
    );
  }
}
