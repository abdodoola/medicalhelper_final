import 'package:flutter/material.dart';
import 'ui.dart';
import 'package:medicalhelper/screens/MainApp/Patient/p_home_page.dart';

class dialogue extends StatelessWidget {
  String text,ques;
  int control;
  dialogue(String text,String ques,int control){
    this.text=text;
    this.ques=ques;
    this.control=control;
  }
  @override
  Widget build(BuildContext context) {
    if(control==0){
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context),
      );
    }else if(control==1){
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild2(context),
      );
    }

  }
  _buildChild(BuildContext context){
    int z=this.ques.indexOf("have");
    String data =this.ques.substring(z+4,this.ques.length-1);
    return new Container(
      decoration:new BoxDecoration(
        color: Colors.white,
       
        borderRadius: BorderRadius.all(new Radius.circular(16.0))
      )
      ,height: 370,
      child: Column(
        children: <Widget>[
         new Container(
           width: double.infinity,
alignment: Alignment.center,
           height: 70,
             decoration:new BoxDecoration(
                 color: Colors.blueAccent,

                 borderRadius: BorderRadius.all(new Radius.circular(16.0))
             )
         ,child: Text(data,style: TextStyle(fontSize: 30,color: Colors.white),),
         )
        ,SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5.0),
             width: double.infinity,
             alignment: Alignment.center,
               height: 250,
               decoration:new BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(new Radius.circular(16.0))
               )
               ,child: new Text(this.text,style: new TextStyle(fontSize: 20),),
           ),
        )
        ,
          new RaisedButton(onPressed: (){
            Navigator.of(context).pop();
          },child: new Text("Ok",style: new TextStyle(color: Colors.blue),),)
        ],
      ),
    );
  }

  _buildChild2(BuildContext context) {
    return new Container(
      height: 200,
      decoration: new BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(new Radius.circular(16)),
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.center,
            width: double.infinity,
            height:100,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(new Radius.circular(16)),
            ),
            child: new Text("Do you have any other problems?",style: TextStyle(color: Colors.blueAccent,fontSize: 20),),
          ),new Padding(padding: EdgeInsets.all(10)),
          new Row(
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(10)),
              new RaisedButton(
                onPressed: (){
                
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context)=> new home(),)
                );
              },child: Text("Yes",style: TextStyle(color: Colors.blueAccent),),
              )
              ,new Padding(padding: EdgeInsets.all(30)),
              new RaisedButton(onPressed: (

                  ){
                Navigator.pushNamed(context, HomePage.id);
              },child: Text("No",style: TextStyle(color: Colors.blueAccent)))
            ],
          )
        ],
      ),
    );
  }
}
