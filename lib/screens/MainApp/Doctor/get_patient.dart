import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/components/constants.dart';
import 'package:medicalhelper/components/rounded_button.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/check_history.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'doc_home_page.dart';

final _fireStore = Firestore.instance;
var patientEmail='';

class GetPatient extends StatefulWidget {
  static const String id = 'patients_screen';
  //static String setpatientEmail = patientEmail;

  @override
  _GetPatientState createState() => _GetPatientState();
}

class _GetPatientState extends State<GetPatient> {
  final _formKey = GlobalKey<FormState>();

  bool showSpinner = false;
  bool userExist = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data.documents;
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () =>
                        Navigator.pushNamed(context, DocHomePage.id),
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
                              validator: (value) =>
                                  value.isEmpty ? 'Enter patient email' : null,
                              onChanged: (value) {
                                patientEmail = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter patient email'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RoundedButton(
                                title: 'Check',
                                colour: Colors.lightBlueAccent,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    for (var uName in users) {
                                      if (uName.data
                                          .containsValue(patientEmail)) {
                                        userExist = true;
                                      }
                                    }
                                    if (userExist == false) {
                                      setState(() {
                                        showSpinner = false;
                                        error = 'Please supply a valid Email';
                                      });
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CheckHistory(getPatientEmail: patientEmail,),
                                          ));
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }
                                  }
                                }),
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
