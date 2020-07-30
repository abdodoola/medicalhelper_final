import 'package:flutter/material.dart';
import 'ui.dart';
import 'cases.dart';
import 'sometips.dart';
class result extends StatelessWidget{
  
  cases case2;
  int res;
  String resstring;
  result(cases case1){
    this.case2=case1;
    this.res=case1.result;
    if(res==1){
      this.resstring="You have to go to the doctor immediately";
    }else if(res==0){
      this.resstring="don't worry just follow my tips and you will be good";
    }

  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.blue,
      appBar: new AppBar(
        title: Text("Check up result"),
      ),
        body: new Center(
        child: Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(120)),
            new Container(
              child: Text(this.resstring,textAlign: TextAlign.center,style: new TextStyle(color: Colors.white,fontSize: 30),),
            ),
            new Padding(padding: EdgeInsets.all(100)),
            new RaisedButton(onPressed: (){
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context)=> new tips(this.case2),)
              );
            },child: Text("Some tips",style: new TextStyle(color: Colors.blue,fontSize:20,fontWeight: FontWeight.bold),),
            )
          ],
        )
        ),
      );
      

  }
  
}