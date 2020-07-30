import 'package:flutter/material.dart';
import 'result.dart';
import 'dialog_helper.dart';
import 'cases.dart';

class Questions extends StatefulWidget {

  int key2;
  Questions({this.key2});
  @override
  _QuestionsState createState() => new _QuestionsState(this.key2);
}


class _QuestionsState extends State<Questions> {


int key3;
cases case1;
int i=0;
_QuestionsState(int key3){
  this.key3=key3;
  this.case1=new cases(key3);
}

void change(){

}
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



          return new Scaffold(
            backgroundColor: Colors.blue,
            appBar: new AppBar(
              title: Text(case1.name),
            ),
            body: new Center(
              child:Container(
                alignment: Alignment.center,
                child:Column(

                  children: <Widget>[
                    new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 250)),
                    new Container(
                      child: Text(case1.questions[i][0],style: new TextStyle(color: Colors.white,fontSize: 30),textAlign: TextAlign.center,),
                    ),
                    new Padding(padding: EdgeInsets.fromLTRB(0, 150, 0, 0)),
                    Row(
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
                        RaisedButton(onPressed: (){

                          case1.yes();
                          if(i<case1.questions.length-1){
                            setState(() {
                              i++;
                            });
                          }else{
                            case1.calcresult();
                            Navigator.of(context).push(
                                new MaterialPageRoute(builder: (context)=> new result(case1),)
                            );
                          }


                        },child: Text("Yes"),),
                        new Padding(padding: EdgeInsets.fromLTRB(90, 0, 0, 0)),
                        RaisedButton(onPressed: (){

                          case1.no();
                          if(i<case1.questions.length-1){
                            setState(() {
                              i++;
                            });
                          }else{
                            case1.calcresult();
                            Navigator.of(context).push(
                                new MaterialPageRoute(builder: (context)=> new result(case1),)
                            );
                          }

                        },child: Text("No"),),
                      ],
                    )
               ,new RaisedButton(onPressed: (){
                 dialoghelper.exit(context,this.case1.questions[i][1],this.case1.questions[i][0],0);
               },child: Text("Don't understand?"),)
                  ],
               
                ),
              )

            ),

          );

  }}