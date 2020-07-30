import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/components/constants.dart';
import 'package:medicalhelper/components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'p_home_page.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class EditProfile extends StatefulWidget {
  static const String id = 'edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  var _currentUserName;
  var _newUserName;
  var _currentHeight;
  var _newHeight;
  var _currentWeight;
  var _newWeight;
  var _currentAge;
  var _newAge;
  var _currentGender;
  var _newGender;
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
        stream: _fireStore.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data.documents;
            for (var userData in messages) {
              if (userData.data.containsValue(loggedInUser.email)) {
                _currentUserName = userData.data['name'];
                _currentHeight = userData.data['height'];
                _currentWeight = userData.data['weight'];
                _currentAge = userData.data['age'];
                _currentGender = userData.data['gender'];
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
                              // User Name
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
                              initialValue: _currentAge,
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your age' : null,
                              onChanged: (value) {
                                _newAge = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your age'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              initialValue: _currentHeight,
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your height' : null,
                              onChanged: (value) {
                                _newHeight = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your height'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              initialValue: _currentWeight,
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your weight' : null,
                              onChanged: (value) {
                                _newWeight = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your weight'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    //Gender
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                    ),
                                    child: Text(
                                      "Gender",
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      value: _newGender ?? _currentGender,
                                      items: <String>['Male', 'Female']
                                          .map((sugar) {
                                        return DropdownMenuItem(
                                          value: sugar,
                                          child: Text(sugar),
                                        );
                                      }).toList(),
                                      onChanged: (val) =>
                                          setState(() => _newGender = val),
                                    ),
                                  ),
                                ],
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
                                  await userCollection
                                      .document(loggedInUser.email)
                                      .setData({
                                    'email': loggedInUser.email,
                                    'name': _newUserName ?? _currentUserName,
                                    'gender': _newGender ?? _currentGender,
                                    'age': _newAge ?? _currentAge,
                                    'height': _newHeight ?? _currentHeight,
                                    'weight': _newWeight ?? _currentWeight,
                                  });
                                  Navigator.pushNamed(context, HomePage.id);
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
