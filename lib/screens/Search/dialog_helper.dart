import 'package:flutter/material.dart';
import 'dialogue.dart';

class dialoghelper{


  static exit(context,String text,String ques,int control)=>showDialog(context: context,builder: (context) => dialogue(text,ques,control));
}
