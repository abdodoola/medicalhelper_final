import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'p_home_page.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class FollowUp extends StatefulWidget {
  static const String id = 'followup_screen';

  @override
  _FollowUpState createState() => _FollowUpState();
}

class _FollowUpState extends State<FollowUp> {
  final _auth = FirebaseAuth.instance;

  var nextTime;
  var medicines;
  bool dataExist;

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
        stream: _fireStore.collection('follow').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final doctorFollowUp = snapshot.data.documents;
            for (var uName in doctorFollowUp) {
              if (uName.data.containsValue(loggedInUser.email)) {
                dataExist = true;
                nextTime = uName.data["nextTime"];
                medicines = uName.data["medicines"];
                break;
              } else {
                dataExist = false;
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
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            "Next time:",
                            style: TextStyle(
                              fontSize: 30.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            nextTime,
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Text(
                            "Medicines:",
                            style: TextStyle(
                              fontSize: 30.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            medicines,
                            style: TextStyle(
                              fontSize:25.0,
                            ),
                          ),
                        ],
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
                      onPressed: () =>
                          Navigator.pushNamed(context, HomePage.id),
                    ),
                    title: Text('Medical Helper'),
                    backgroundColor: Colors.teal,
                  ),
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: Text(
                        "No Follow Up",
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
