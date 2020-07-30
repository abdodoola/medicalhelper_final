import 'package:flutter/material.dart';

import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
//import 'package:ai/ai.dart';


class cases{
  int count,result,key1;
  List<int> answers=new List();
  List<String> questions=new List(),lines=new List();
  String name="";
  String path="";
  String data;
  int size,no_rows,no_col;
  double test_percentage=0.2;
 List<List<double>> expectedresulttrain=new List(),expectedresultstest=new List();
  List<List<double>> train=new List(),test=new List();

  cases(int key2){
    this.key1=key2;
    calcquestions(key2);
  }

  Future<void> read() async {
    this.data=await rootBundle.loadString("csvfiles/"+this.path);
    preprocess();
  }

  void preprocess(){
   this.lines=this.data.split("\n");
   this.size=this.lines.length-1;
   this.no_rows=this.lines.length;
   this.no_col=this.lines[0].split(",").length-1;
   int sizeoftrain=((1.0-this.test_percentage)*this.size).toInt();
   int sizeoftest=this.size-sizeoftrain;
   List<double> temp=new List();
   List<String> splittedstring=new List();

   for(int i=1;i<sizeoftrain;i++){
     for(int j=0;j<this.no_col;j++){
       splittedstring=lines[i].split(",");
       temp.add(double.parse(splittedstring[j]));
     }
     List<double> temp2=new List();
     for(int u=0;u<temp.length;u++){
       temp2.add(temp[u]);
     }

     this.train.add(temp2);

     temp.clear();
     List<double> temp3=new List();
     temp3.add(double.parse(this.lines[i].split(",")[this.no_col]));
     this.expectedresulttrain.add(temp3);
   }
   temp.clear();
   for(int i=sizeoftrain;i<this.size;i++){
     for(int j=0;j<this.no_col;j++){
       splittedstring=lines[i].split(",");
       temp.add(double.parse(splittedstring[j]));
      // temp.add(double.parse(lines[i][j]));
     }
     List<double> temp2=new List();
     for(int u=0;u<temp.length;u++){
       temp2.add(temp[u]);
     }
     this.test.add(temp2);
     temp.clear();
     List<double> temp4=new List();
     temp4.add(double.parse(this.lines[i].split(",")[this.no_col]));
     this.expectedresultstest.add(temp4);
   }

  }

  void neuralnetwork(){
   // final nn=MLP.from(Structure());
    //nn.train(input: this.train, expected: this.expectedresulttrain, learningRate: 0.1, epoch: 5000, visualize: true);
  }

  void yes(){
    answers.add(1);
  }

  void no(){
    answers.add(0);
  }

  void calcresult(){
    int max=0;
    List<int> temp=answers;
    for(int i=0;i<temp.length;i++){
      if(temp.removeAt(i)==1){
        max++;
      }
    }
    if(max>=count){
      result=1;
    }else{
      result=0;
    }
  }

  void calcquestions(int key){

    switch(key){
      case 1:
        this.path="Eating disorders.csv";
        this.name="Eating disorders";
        count=3;
        this.questions.add("do you have anorexia?");
        this.questions.add("do you have polyphagia?");
        this.questions.add("do you have sudden weight loss?");
        this.questions.add("do you have rapid weight gain?");
        this.questions.add("do you have polydipsia?");
        break;
      case 2:
        this.path="GIT.csv";
        count=5;
        this.name="GIT disorders";
        this.questions.add("do you have diarrhea?");
        this.questions.add("do you have constipation?");
        this.questions.add("do you have melena?");
        this.questions.add("do you have tenesmus?");
        this.questions.add("do you have abdominal cramps?");
        this.questions.add("do you have nausea?");
        this.questions.add("do you have vomiting?");
        this.questions.add("do you have hematemesis?");
        this.questions.add("do you have bloating?");

        break;
      case 3:
        this.path="Urination.csv";
        count=8;
        this.name="Urination disorders";
        this.questions.add("do you have dysuria?");
        this.questions.add("do you have polyuria?");
        this.questions.add("do you have oliguria?");
        this.questions.add("do you have nocturia?");
        this.questions.add("do you have nocturnal enuresis?");
        this.questions.add("do you have urgency?");
        this.questions.add("do you have incontinence?");
        this.questions.add("do you have Dark urine?");
        this.questions.add("do you have pale urine?");
        this.questions.add("do you have clear urine?");
        this.questions.add("do you have turbid urine?");
        this.questions.add("do you have bloody urine?");
        this.questions.add("do you have ascites?");
        this.questions.add("do you have jaunice?");
        this.questions.add("do you have pallor?");
        this.questions.add("do you have edema?");

        break;
      case 4:
        this.path="Skin.csv";
        count=5;
        this.name="Skin manifestation";
        this.questions.add("do you have acne?");
        this.questions.add("do you have Skin redness?");
        this.questions.add("do you have ulcers?");
        this.questions.add("do you have nevus?");
        this.questions.add("do you have raised ulcers?");
        this.questions.add("do you have skin rash?");
        this.questions.add("do you have itching?");
        this.questions.add("do you have harshness?");
        this.questions.add("do you have scaling of skin?");
        this.questions.add("do you have peeling of skin?");

        break;
      case 5:
        this.path="Respiratory disorders.csv";
        count=3;
        this.name="Respiratory disorders";
        this.questions.add("do you have dyspnea?");
        this.questions.add("do you have tachypnea?");
        this.questions.add("do you have wheezes?");
        this.questions.add("do you have dry cough?");
        this.questions.add("do you have reproductive cough?");
        this.questions.add("do you have hemoptysis?");
        break;
      case 6:
        this.path="Heart pain.csv";
        count=5;
        this.name="heart disorders";
        this.questions.add("do you have dyspnea?");
        this.questions.add("do you have palpitations and pounding in chest?");
        this.questions.add("do you have rapid or irregular heart beats?");
        this.questions.add("do you have chest pain referring to arms?");
        this.questions.add("do you have heartburn?");
        this.questions.add("do you have headache?");
        this.questions.add("do you have fever?");
        this.questions.add("do you have weakness and fatigability?");
        this.questions.add("do you have dizziness?");
        this.questions.add("do you have lack of energy?");
        break;
    }
  }

}