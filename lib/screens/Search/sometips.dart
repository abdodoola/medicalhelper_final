import 'package:flutter/material.dart';
import 'dialog_helper.dart';
import 'cases.dart';
class tips extends StatefulWidget {
  cases case1;
  List<String> names=new List();
  List<Widget> widgets=new List();
  List<int> no=new List();
  Icon icon=new Icon(Icons.chevron_right,color: Colors.blue,);
  tips(cases case1){
    this.case1=case1;

    for(int i=0;i<this.case1.answers.length;i++){
      if(this.case1.answers[i]==1){
        no.add(i);
        this.names.add(this.case1.questions[i][0].substring(this.case1.questions[i][0].indexOf("have")+4,this.case1.questions[i][0].length-1));
      }
    }

  for(int j=0;j<names.length;j++){
      widgets.add(Container(
        child: new ListTile(

          title: Text(names[j],style: new TextStyle(fontSize: 30,color: Colors.blue),textAlign: TextAlign.left,),
         subtitle: Text(this.case1.questions[no[j]][2],style: new TextStyle(fontSize: 20,color: Colors.blue)),

        ),
        alignment: Alignment.center,
        color: Colors.white,
        margin: EdgeInsets.only(right: 0,left: 0,bottom: 10,top: 10),
      ));

  }

  }


  @override
  _tipsState createState() => _tipsState();
}

class _tipsState extends State<tips> {


  @override
  Widget build(BuildContext context) {
    int i=0;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: new AppBar(
        title: Text("Tips",textAlign: TextAlign.center,),
        actions: <Widget>[new IconButton(icon: new Icon(Icons.check), onPressed: (){
          dialoghelper.exit(context,null,"",1);
        }),]
      ),
      body:new ListView(

        children: widget.widgets
      )
    );
  }
}
