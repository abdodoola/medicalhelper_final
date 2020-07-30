import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicalhelper/screens/MainApp/Doctor/write_follow_up.dart';
import 'doc_home_page.dart';

final _fireStore = Firestore.instance;

class CheckHistory extends StatefulWidget {
  static const String id = 'check_history_screen';

  String getPatientEmail;
  CheckHistory({Key key, @required this.getPatientEmail}) : super(key: key);


  @override
  _CheckHistoryState createState() => _CheckHistoryState();
}

class _CheckHistoryState extends State<CheckHistory> {
  var chronicDiseases;
  var previousDiseases;
  bool dataExist=false;

  @override
  Widget build(BuildContext context) {
    var patientEmail=widget.getPatientEmail;
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('history').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final usersHistory = snapshot.data.documents;
            for (var userData in usersHistory) {
              if (userData.data.containsValue(patientEmail)) {
                chronicDiseases = userData.data["chronicDiseases"];
                previousDiseases = userData.data["previousDiseases"];
                dataExist = true;
              }
            }
            if (dataExist) {
              return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
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
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(220, 20, 0, 0),
                            child: Material(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(30.0),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WriteFollowUp(getPatientEmail: patientEmail,),
                                      ));
                                },
                                minWidth: 100.0,
                                height: 42.0,
                                child: Text(
                                  "Add FollowUp",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Chronic Diseases:",
                            style: TextStyle(
                              fontSize: 25.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            chronicDiseases,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          Text(
                            "Previous Diseases:",
                            style: TextStyle(
                              fontSize: 25.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            previousDiseases,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }else{
              return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
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
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(220, 20, 0, 0),
                            child: Material(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(30.0),
                              child: MaterialButton(
                                onPressed: () {
                                  print('pati: $patientEmail');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WriteFollowUp(getPatientEmail: patientEmail,),
                                      ));
                                },
                                minWidth: 100.0,
                                height: 42.0,
                                child: Text(
                                  "Add FollowUp",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 200),
                           Center(
                             child: Text(
                                "No History",
                                style: TextStyle(fontSize: 35.0),

                          ),
                           ),

                        ],
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: Text(
                        "No History",
                        style: TextStyle(fontSize: 35.0),
                      ),
                    ),
                  ), */
                ),
              );
            }

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
