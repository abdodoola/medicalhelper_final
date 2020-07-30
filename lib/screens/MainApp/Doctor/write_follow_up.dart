import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'doc_home_page.dart';

FirebaseUser loggedInUser;
var docEmail;
final _fireStore = Firestore.instance;

class WriteFollowUp extends StatefulWidget {
  static const String id = 'write_follow_up_screen';

  String getPatientEmail;
  WriteFollowUp({Key key, @required this.getPatientEmail}) : super(key: key);

  @override
  _WriteFollowUpState createState() => _WriteFollowUpState();
}

class _WriteFollowUpState extends State<WriteFollowUp> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference userCollection =
      Firestore.instance.collection('follow');
  final CollectionReference userCollection2 =
      Firestore.instance.collection('appointments');

  var _nextTime;
  var _medicines;
  bool showSpinner = false;
  var patientName;

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
    var patientEmail = widget.getPatientEmail;
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final usersNames = snapshot.data.documents;
            for (var userData in usersNames) {
              if (userData.data.containsValue(patientEmail)) {
                patientName = userData.data["name"];
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
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 150.0,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            validator: (value) => value.isEmpty
                                ? 'Enter next time checkup'
                                : null,
                            onChanged: (value) {
                              _nextTime = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter next time checkup',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            validator: (value) =>
                                value.isEmpty ? 'Enter medicines' : null,
                            onChanged: (value) {
                              _medicines = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter medicines',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                          ),
                          RoundedButton(
                            title: 'Save',
                            colour: Colors.lightBlueAccent,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                docEmail = loggedInUser.email;
                                await userCollection.document().setData({
                                  'patientEmail': patientEmail,
                                  'nextTime': _nextTime,
                                  'medicines': _medicines,
                                });
                                await userCollection2.document().setData({
                                  'docEmail': loggedInUser.email,
                                  'patientName': patientName,
                                  'nextTime': _nextTime,
                                });
                                Navigator.pushNamed(context, DocHomePage.id);
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
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
