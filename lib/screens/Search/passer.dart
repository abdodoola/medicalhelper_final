import 'package:flutter/material.dart';
import 'questions.dart';
class pass extends StatelessWidget{
  int key1;


  pass({this.key1});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        
        title: new Text("Check up"),
      ),

      backgroundColor: Colors.blue,

      body:new Center(
      child:Container(

      alignment: Alignment.center,
      child: Text('I am going to ask you a few questions',style: TextStyle(color: Colors.white,fontSize:30 ),textAlign: TextAlign.center,),
    ),
      )

      ,floatingActionButton: new RaisedButton(onPressed:()=>Navigator.of(context).push(
    new MaterialPageRoute(builder: (context)=> new Questions(key2:key1),)
    )
    ,child: Text("Ok"),)
    );
  }

}

