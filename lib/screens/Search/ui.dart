import 'package:flutter/material.dart';
import 'passer.dart';
import 'neuralcases.dart';
class home extends StatelessWidget{
  static const String id = 'search_page';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: new IconButton(icon: new Icon(Icons.keyboard_backspace), onPressed: null),
        title: new Text("Check up",style: new TextStyle(fontSize: 20,color: Colors.white)),
      ),
      body: new Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: new ListView(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.all(10)),
            new Container(
              alignment: Alignment.center,
              child: Text("What are you feeling excatly?",style: new TextStyle(fontSize: 25,color: Colors.white)),
            ),
            new Padding(padding: const EdgeInsets.all(10)),
            ListTile(
              title:Text("Stomach pain",style: new TextStyle(fontSize: 25,color: Colors.white)),
              onTap:  ()=>Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context)=> new pass(key1:2))
              ),

            ),
            ListTile(
              title:Text("Urination problems",style: new TextStyle(fontSize: 25,color: Colors.white)),
              onTap:  ()=>Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context)=> new pass(key1:3))
              ),

            ),
            ListTile(
              title:Text("Skin problems",style: new TextStyle(fontSize: 25,color: Colors.white)),
              onTap:  ()=>Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context)=> new pass(key1:4))
              ),

            ),
            ListTile(
              title:Text("Respiration problems",style: new TextStyle(fontSize: 25,color: Colors.white)),
              onTap:  ()=>Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context)=> new pass(key1:5))
              ),

            ),
            ListTile(
              title:Text("Heart pain",style: new TextStyle(fontSize: 25,color: Colors.white)),
              onTap:  ()=>Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context)=> new pass(key1:6))
              ),

            ),
            ListTile(
              title:Text("COVID-19",style: new TextStyle(fontSize: 25,color: Colors.white)),
              onTap:  ()=>Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context)=> new pass(key1:7))
              ),

            ),
          ],
        ),
      ),
    );
  }

}
