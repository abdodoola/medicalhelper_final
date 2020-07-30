import 'package:flutter/material.dart';
import 'package:medicalhelper/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicalhelper/components/rounded_button.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseUser loggedInUser;

class RegUser extends StatefulWidget {
  static const String id = 'reg_user';

  @override
  _RegUserState createState() => _RegUserState();
}

class _RegUserState extends State<RegUser> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  String name;
  String height;
  String weight;
  String gender = 'Male';
  String age;
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
                  validator: (value) => value.isEmpty ? 'Enter your age' : null,
                  onChanged: (value) {
                    age = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter your age'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  validator: (value) =>
                      value.isEmpty ? 'Enter your height' : null,
                  onChanged: (value) {
                    height = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your height'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  validator: (value) =>
                      value.isEmpty ? 'Enter your weight' : null,
                  onChanged: (value) {
                    weight = value;
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
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color: Colors.blueAccent),
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
                        child: DropdownButton<String>(
                          items: <String>['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            );
                          }).toList(),
                          value: gender,
                          onChanged: (value) {
                            gender = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
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
                        'gender': gender,
                        'age': age,
                        'height': height,
                        'weight': weight,
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
    );
  }
}
