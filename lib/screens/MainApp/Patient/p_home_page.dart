import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/components/home_button.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_edit_profile.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_follow_up.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_history.dart';
import 'package:medicalhelper/screens/Reg&Log/welcome_screen.dart';
import 'package:medicalhelper/screens/Search/ui.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class HomePage extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        stream: _fireStore.collection('user').snapshots(),
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
                        Navigator.pushNamed(context, EditProfile.id);
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
                            Navigator.pushNamed(context, home.id);
                          },
                          title: 'Search',
                          icon: Icons.search,
                        ),
                        HomeButton(
                          onPressed: () {
                            Navigator.pushNamed(context, History.id);
                          },
                          title: 'History',
                          icon: Icons.history,
                        ),
                        HomeButton(
                          onPressed: () {
                            Navigator.pushNamed(context, FollowUp.id);
                          },
                          title: 'Follow up',
                          icon: Icons.edit,
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
