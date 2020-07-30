import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_edit_history.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_home_page.dart';

class History extends StatefulWidget {
  static const String id = 'history';

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  var chronicDiseases;
  var previousDiseases;
  bool dataExist=false;

  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
  Firestore.instance.collection('history');

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
        stream: _fireStore.collection('history').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data.documents;
            for (var userData in messages) {
              if (userData.data.containsValue(loggedInUser.email)) {
                dataExist = true;
                chronicDiseases = userData.data["chronicDiseases"];
                previousDiseases = userData.data["previousDiseases"];
              }
            }
            if (dataExist == true) {
              return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () =>
                          Navigator.pushNamed(context, HomePage.id),
                    ),
                    actions: <Widget>[
                      FlatButton.icon(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, EditHistory.id);
                        },
                      ),
                    ],
                    title: Text('Medical Helper'),
                    backgroundColor: Colors.teal,
                  ),
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Chronic Diseases:",
                              style: TextStyle(
                                fontSize: 25.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              chronicDiseases,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              height: 60.0,
                            ),
                            Text(
                              "Previous Diseases:",
                              style: TextStyle(
                                fontSize: 25.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              previousDiseases,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else{
              return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () =>
                          Navigator.pushNamed(context, HomePage.id),
                    ),
                    actions: <Widget>[
                      FlatButton.icon(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, EditHistory.id);
                        },
                      ),
                    ],
                    title: Text('Medical Helper'),
                    backgroundColor: Colors.teal,
                  ),
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: Text(
                        "No History",
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
