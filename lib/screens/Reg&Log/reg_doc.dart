import 'package:flutter/material.dart';
import 'package:medicalhelper/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicalhelper/components/rounded_button.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/doc_home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseUser loggedInUser;

class RegDoc extends StatefulWidget {
  static const String id = 'doc_user';

  @override
  _RegDocState createState() => _RegDocState();
}

class _RegDocState extends State<RegDoc> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference userCollection =
      Firestore.instance.collection('doctor');

  String name;
  String specilaization;
  String doctorID;
  String hospital;
  String address;
  String telephone;
  bool showSpinner = false;
  String error = '';

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
                  validator: (value) =>
                      value.isEmpty ? 'Enter your name' : null,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your name'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  validator: (value) => value.isEmpty ? 'Enter your specilaization' : null,
                  onChanged: (value) {
                    specilaization = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter your specilaization'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  validator: (value) =>
                      value.isEmpty ? 'Enter your doctor ID' : null,
                  onChanged: (value) {
                    doctorID = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your doctor ID'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  validator: (value) =>
                      value.isEmpty ? 'Enter your hospital' : null,
                  onChanged: (value) {
                    hospital = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your hospital'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  validator: (value) =>
                      value.isEmpty ? 'Enter your address' : null,
                  onChanged: (value) {
                    address = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your address'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  validator: (value) =>
                      value.isEmpty ? 'Enter your telephone' : null,
                  onChanged: (value) {
                    telephone = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your telephone'),
                ),
                RoundedButton(
                  title: 'Register',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      await userCollection
                          .document(loggedInUser.email)
                          .setData({
                        'email':loggedInUser.email,    
                        'name': name,
                        'specilaization': specilaization,
                        'doctorID': doctorID,
                        'hospital': hospital,
                        'address': address,
                        'telephone': telephone,
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
    );
  }
}
