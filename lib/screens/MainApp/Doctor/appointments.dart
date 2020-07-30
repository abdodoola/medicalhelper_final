import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class Appointments extends StatefulWidget {
  static const String id = 'appointments_screen';

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final _auth = FirebaseAuth.instance;

  List<String> patientName = new List();
  List<String> date = new List();
  bool dataExist = false;
  var counter = 0;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('appointments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final doctorFollowUp = snapshot.data.documents;
            List<PatientsAppointments> patientsAppointments = [];
            for (var uName in doctorFollowUp) {
              if (uName.data.containsValue(loggedInUser.email)) {

                final patientName = uName.data['patientName'];
                final date = uName.data['nextTime'];
               // patientName.add(uName.data['patientName']);
               // date.add(uName.data['nextTime']);

                final appointment = PatientsAppointments(patientName: patientName,date: date,);
                patientsAppointments.add(appointment);
                dataExist = true;
              }
            }
            if (dataExist) {
              return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text('Medical Helper'),
                    backgroundColor: Colors.teal,
                  ),
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: ListView(
                        children: patientsAppointments,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text('Medical Helper'),
                    backgroundColor: Colors.teal,
                  ),
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: Text(
                        "No Appointments",
                        style: TextStyle(fontSize: 35.0),
                      ),
                    ),
                  ),
                ),
              );
            }
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.tealAccent,
                  size: 50.0,
                ),
              ),
            );
          }
        });
  }
}

class PatientsAppointments extends StatelessWidget {
  final String patientName;
  final String date;

  PatientsAppointments({this.patientName, this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          "Patient Name: $patientName",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        Text(
          "Date: $date",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
