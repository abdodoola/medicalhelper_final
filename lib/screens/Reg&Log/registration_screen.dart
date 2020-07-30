import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalhelper/components/rounded_button.dart';
import 'package:medicalhelper/components/constants.dart';
import 'package:medicalhelper/screens/Reg&Log/reg_user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'reg_doc.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registeration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;
  bool showSpinner = false;
  String error = '';
  int group = 1;

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
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value.isEmpty ? 'Enter an EMail' : null,
                    onChanged: (value) {
                      //Do something with the user input.
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
                        ? 'Enter a password more than 6 charachters'
                        : null,
                    onChanged: (value) {
                      //Do something with the user input.
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
                  title: 'Register',
                  colour: Colors.blueAccent,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        dynamic newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser == null) {
                          setState(() {
                            showSpinner = false;
                            error = 'Please supply a valid Email';
                          });
                        } else {
                          if(group==1){
                          Navigator.pushNamed(context, RegUser.id);
                        }else if(group==2){
                          Navigator.pushNamed(context, RegDoc.id);
                        }
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                          error = 'Please supply a valid Email';
                        });
                        print(e);
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
