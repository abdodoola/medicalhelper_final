import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/components/home_button.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/appointments.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/d_edit_profile.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/get_patient.dart';
import 'package:medicalhelper/screens/Reg&Log/welcome_screen.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class DocHomePage extends StatefulWidget {
  static const String id = 'doc_home_screen';

  @override
  _DocHomePageState createState() => _DocHomePageState();
}

class _DocHomePageState extends State<DocHomePage> {
  final _auth = FirebaseAuth.instance;
  var _userName;

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
        stream: _fireStore.collection('doctor').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data.documents;
            for (var uName in messages) {
              if (uName.data.containsValue(loggedInUser.email)) {
                _userName = uName.data['name'];
              }
            }
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  leading: null,
                  actions: <Widget>[
                    FlatButton.icon(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      label: Text(
                        ' Edit\n Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, DocEditProfile.id);
                      },
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Log out',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, WelcomeScreen.id);
                      },
                    ),
                  ],
                  title: Text('Medical Helper'),
                  backgroundColor: Colors.teal,
                ),
                backgroundColor: Colors.teal,
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 150.0,
                        ),
                        Center(
                          child: Text(
                            _userName,
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        HomeButton(
                          onPressed: () {
                            Navigator.pushNamed(context, GetPatient.id);
                          },
                          title: 'Patients',
                          icon: Icons.person,
                        ),
                        HomeButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Appointments.id);
                          },
                          title: 'Appointments',
                          icon: Icons.timer,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
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
