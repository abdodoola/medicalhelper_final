import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/components/constants.dart';
import 'package:medicalhelper/components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'doc_home_page.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class DocEditProfile extends StatefulWidget {
  static const String id = 'doc_edit_profile';

  @override
  _DocEditProfileState createState() => _DocEditProfileState();
}

class _DocEditProfileState extends State<DocEditProfile> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference userCollection =
      Firestore.instance.collection('doctor');

  var _currentUserName;
  var _newUserName;
  var _currentSpecilaization;
  var _newSpecilaization;
  var _currentDoctorID;
  var _newDoctorID;
  var _currentHospital;
  var _newHospital;
  var _currentAddress;
  var _newAddress;
  var _currentTelephone;
  var _newTelephone;
  bool showSpinner = false;

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
            for (var userData in messages) {
              if (userData.data.containsValue(loggedInUser.email)) {
                _currentUserName = userData.data['name'];
                _currentSpecilaization = userData.data['specilaization'];
                _currentDoctorID = userData.data['doctorID'];
                _currentHospital = userData.data['hospital'];
                _currentAddress = userData.data['address'];
                _currentTelephone = userData.data['telephone'];
              }
            }
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    FlatButton.icon(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Home',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, DocHomePage.id);
                      },
                    ),
                  ],
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
                              initialValue: _currentUserName,
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your name' : null,
                              onChanged: (value) {
                                _newUserName = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your name'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              initialValue: _currentSpecilaization,
                              textAlign: TextAlign.center,
                              validator: (value) => value.isEmpty
                                  ? 'Enter your specilaization'
                                  : null,
                              onChanged: (value) {
                                _newSpecilaization = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your specilaization'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              initialValue: _currentDoctorID,
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your doctor ID' : null,
                              onChanged: (value) {
                                _newDoctorID = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your doctor ID'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              initialValue: _currentHospital,
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your hospital' : null,
                              onChanged: (value) {
                                _newHospital = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your hospital'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              initialValue: _currentAddress,
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your address' : null,
                              onChanged: (value) {
                                _newAddress = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your address'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              initialValue: _currentTelephone,
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your telephone' : null,
                              onChanged: (value) {
                                _newTelephone = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your telephone'),
                            ),
                            RoundedButton(
                              title: 'Save',
                              colour: Colors.lightBlueAccent,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  await userCollection
                                      .document(loggedInUser.email)
                                      .setData({
                                    'email': loggedInUser.email,
                                    'name': _newUserName ??
                                        _currentUserName,
                                    'specilaization': _newSpecilaization ??
                                        _currentSpecilaization,
                                    'doctorID':
                                        _newDoctorID ?? _currentDoctorID,
                                    'hospital':
                                        _newHospital ?? _currentHospital,
                                    'address': _newAddress ?? _currentAddress,
                                    'telephone':
                                        _newTelephone ?? _currentTelephone,
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
