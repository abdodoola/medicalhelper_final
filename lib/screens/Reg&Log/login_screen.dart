import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/components/rounded_button.dart';
import 'package:medicalhelper/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/doc_home_page.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _fireStore = Firestore.instance;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;
  bool showSpinner = false;
  String error = '';
  int group = 1;
  bool userExist=false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          final users = snapshot.data.documents;
          return StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('doctor').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                final doctors = snapshot.data.documents;
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: ModalProgressHUD(
                    inAsyncCall: showSpinner,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/logo.png'),
                              height: 200.0,
                            ),
                            TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    value.isEmpty ? 'Enter an EMail' : null,
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your E-Mail')),
                            SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                                textAlign: TextAlign.center,
                                obscureText: true,
                                validator: (value) => value.length < 6
                                    ? 'Enter a password'
                                    : null,
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your password')),
                            SizedBox(
                              height: 24.0,
                            ),
                            Column(
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Patient'),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: group,
                                    onChanged: (value) {
                                      setState(() {
                                        group = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Doctor'),
                                  leading: Radio(
                                    value: 2,
                                    groupValue: group,
                                    onChanged: (value) {
                                      setState(() {
                                        group = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            RoundedButton(
                              title: 'Log in',
                              colour: Colors.lightBlueAccent,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                    dynamic newUser =
                                        await _auth.signInWithEmailAndPassword(
                                            email: email, password: password);
                                    if (group == 1) {
                                      for (var uName in users) {
                                      if (uName.data.containsValue(email)) {
                                        userExist=true;
                                      }
                                    }
                                    }    
                                    if (group == 2) {
                                      for (var uName in doctors) {
                                      if (uName.data.containsValue(email)) {
                                        userExist=true;
                                      }
                                    }
                                    }   
                                    if (userExist==false) {
                                      setState(() {
                                        showSpinner = false;
                                        error =
                                            'Please supply a valid Email and password';
                                      });
                                    } else if(newUser!=null && userExist==true) {
                                      if (group == 1) {
                                        Navigator.pushNamed(
                                            context, HomePage.id);
                                      } else if (group == 2) {
                                        Navigator.pushNamed(
                                            context, DocHomePage.id);
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }
                                  } catch (e) {
                                    setState(() {
                                      showSpinner = false;
                                      error =
                                          'Please supply a valid Email and password';
                                    });
                                    print(e);
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                }else{
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
          }else{
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
