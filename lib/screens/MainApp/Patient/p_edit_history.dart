import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_history.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditHistory extends StatefulWidget {
  static const String id = 'edit_history';

  @override
  _EditHistoryState createState() => _EditHistoryState();
}

class _EditHistoryState extends State<EditHistory> {
  var _currentChronicDiseases;
  var _newChronicDiseases;
  var _currentPreviousDiseases;
  var _newPreviousDiseases;
  bool showSpinner = false;

  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  final _formKey = GlobalKey<FormState>();
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
                _currentChronicDiseases = userData.data["chronicDiseases"];
                _currentPreviousDiseases = userData.data["previousDiseases"];
              }
            }
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
                body: ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 50.0,
                            ),
                            Text(
                              "Chronic Diseases:",
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: TextFormField(
                                initialValue: _currentChronicDiseases,
                                textAlign: TextAlign.start,
                                validator: (value) => value.isEmpty
                                    ? 'Enter chronic diseases'
                                    : null,
                                onChanged: (value) {
                                  _newChronicDiseases = value;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 40.0, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Text(
                              "Previous Diseases:",
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: TextFormField(
                                initialValue: _currentPreviousDiseases,
                                textAlign: TextAlign.start,
                                validator: (value) => value.isEmpty
                                    ? 'Enter previous diseases'
                                    : null,
                                onChanged: (value) {
                                  _newPreviousDiseases = value;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 40.0, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Material(
                                elevation: 5.0,
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(30.0),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      await userCollection
                                          .document(loggedInUser.email)
                                          .setData({
                                        'email': loggedInUser.email,
                                        'chronicDiseases':
                                            _newChronicDiseases ??
                                                _currentChronicDiseases,
                                        'previousDiseases':
                                            _newPreviousDiseases ??
                                                _currentPreviousDiseases,
                                      });
                                      Navigator.pushNamed(context, History.id);
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }
                                  },
                                  minWidth: 100.0,
                                  height: 42.0,
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
