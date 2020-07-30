


import 'dart:developer';

import 'package:flutter/cupertino.dart';

class cases{
  int count,result,key1,pointer=0;
  List<int> answers=new List();
 List<List<String>> questions=new List();
 String name="";

 cases(int key2){
   this.key1=key2;
   calcquestions(key2);
 }

  void yes(){
    answers.add(1);
  }

  void no(){
    answers.add(0);
  }

  void addpointer(){
    this.pointer++;
  }

  void calcresult(){
    int max=0;
    List<int> temp=answers;
   for(int i=0;i<temp.length;i++){
     if(temp[i]==1){
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
   List<String> temp;
    switch(key){
      case 1:
        this.name="Eating disorders";
        count=3;
        temp=new List();
        temp.add("Do you have anorexia?");
        temp.add("An eating disorder characterized by markedly reduced appetite or total aversion to food. Anorexia is a serious psychological disorder. It is a condition that goes well beyond out-of-control dieting.");
        temp.add("Anorexia is not physical symptom as it is psychological symptom you need to accept yourself and love yourself and don't listen alot to people opinion");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have polyphagia?");
        temp.add("Excessive appetite or eating");
        temp.add("You should make a diabetes test");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have sudden weight loss?");
        temp.add("Unexplained weight loss is a noticeable drop in body weight that occurs even if the person is not trying to lose weight.");
        temp.add("It’s normal for your body weight to fluctuate. However, if you’re losing weight without changing your habits, something else might be going on.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have rapid weight gain?");
        temp.add("Unexplained weight gain occurs even if the person is not trying to gain weight.");
        temp.add("It’s normal for your body weight to fluctuate. However, if you’re gaining weight without changing your habits, something else might be going on.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have polydipsia?");
        temp.add("Polydipsia is a medical name for the feeling of extreme thirstiness");
        temp.add("Limit your fluid you drink");
        this.questions.add(temp);
        break;
      case 2:
        count=9;
        this.name="GIT disorders";
        temp=new List();
        temp.add("Do you have anorexia?");
        temp.add("An eating disorder characterized by markedly reduced appetite or total aversion to food. Anorexia is a serious psychological disorder. It is a condition that goes well beyond out-of-control dieting.");
        temp.add("Anorexia is not physical symptom as it is psychological symptom you need to accept yourself and love yourself and don't listen alot to people opinion");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have polyphagia?");
        temp.add("Excessive appetite or eating");
        temp.add("You should make a diabetes test");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have sudden weight loss?");
        temp.add("Unexplained weight loss is a noticeable drop in body weight that occurs even if the person is not trying to lose weight.");
        temp.add("It’s normal for your body weight to fluctuate. However, if you’re losing weight without changing your habits, something else might be going on.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have rapid weight gain?");
        temp.add("Unexplained weight gain occurs even if the person is not trying to gain weight.");
        temp.add("It’s normal for your body weight to fluctuate. However, if you’re gaining weight without changing your habits, something else might be going on.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have polydipsia?");
        temp.add("Polydipsia is a medical name for the feeling of extreme thirstiness");
        temp.add("Limit your fluid you drink");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have diarrhea?");
        temp.add("Diarrhea is loose, watery stools (bowel movements). You have diarrhea if you have loose stools three or more times in one day. Acute diarrhea is diarrhea that lasts a short time. It is a common problem. It usually lasts about one or two days, but it may last longer.");
        temp.add("Diarrhea should go away in a few days without treatment. Until you feel better, rest, drink enough fluids, and watch what you eat.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have constipation?");
        temp.add("A condition in which there is difficulty in emptying the bowels, usually associated with hardened faeces.");
        temp.add("Treatment for chronic constipation usually begins with diet and lifestyle changes meant to increase the speed at which stool moves through your intestines. If those changes don't help, your doctor may recommend medications or surgery.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have melena?");
        temp.add("The production of dark sticky faeces containing partly digested blood, as a result of internal bleeding or the swallowing of blood.");
        temp.add("For managing melena:\n1- don't take aspirin\n2- don't drink alcohol or caffain\n3- don't smoke");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have tenesmus?");
        temp.add("A feeling of urgent need to defecate or urinate, with a straining but unsuccessful effort to do so");
        temp.add("1- Eat alot of fibers\n2- Drink alot\n3- Do alot of physical activity");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have abdominal cramps?");
        temp.add("stomach ache");
        temp.add("1- Eat a healthy diet.\n2- Drink water frequently.\n3- Exercise regularly.\n4- Eat smaller meals.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have nausea?");
        temp.add("A feeling of loathing or disgust.");
        temp.add("1- Drink alot of water\n2- Stay away from fried food\n3- Eat small meals");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have vomiting?");
        temp.add("Vomiting, or throwing up, is a forceful discharge of stomach contents. It can be a one-time event linked to something that doesn't settle right in the stomach.");
        temp.add("1- Eat small meals\n2- Rest and avoid physical activity");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have hematemesis?");
        temp.add("Vomiting of blood");
        temp.add("Depending on the amount of blood lost, you may need a blood transfusion,you need to go the doctor");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have bloating?");
        temp.add("A condition in which the stomach swells and feels full and uncomfortable");
        temp.add("1- Avoid chewing gum\n2- Limit your intake of carbonated drinks\n3- Eat slowly\n4- Use lactose free dairy products");
        this.questions.add(temp);
        break;
      case 3:
        count=8;
        this.name="Urination disorders";
        temp=new List();
        temp.add("Do you have dysuria?");
        temp.add("Painful or difficult urination.");
        temp.add("You need to see doctor if the pain is consistent");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have polyuria?");
        temp.add("Production of abnormally large volumes of dilute urine.");
        temp.add("Cut back on how much fluid you drink, especially those that have alcohol and caffeine.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have oliguria?");
        temp.add("The production of abnormally small amounts of urine.");
        temp.add("Drink alot of water");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have nocturia?");
        temp.add("Nocturia is a condition in which you wake up during the night because you have to urinate.");
        temp.add("Nocturia can be a symptom of a more serious condition, such as diabetes");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have nocturnal enuresis?");
        temp.add("Nocturnal enuresis is involuntary urination that happens at night while sleeping");
        temp.add("This can be a symptom for a diabetes so you should have diabetes check");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have urgency?");
        temp.add("Urgent urination is a sudden, strong need to urinate");
        temp.add("Delay urination after you get the urge to go");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have incontinence?");
        temp.add("Inability of the body to control the evacuative functions of urination ");
        temp.add("Learn how to delay urination whenever there is an urge to do so.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have dark urine?");
        temp.add("The urine is darkly coloured");
        temp.add("Don't eat alot of salts");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have pale urine?");
        temp.add("The colour of urine is yellow");
        temp.add("Drink alot of water");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have clear urine?");
        temp.add("The urine is just like water (transparent)");
        temp.add("It is fine");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have turbid urine?");
        temp.add("The urine is not transparent");
        temp.add("Drink alot of water");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have bloody urine");
        temp.add("There is blood with your urine");
        temp.add("You should go to the doctor");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have ascites?");
        temp.add("Ascites is a condition where fluid builds up in the abdomen");
        temp.add("You should go to the doctor");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have jaunice?");
        temp.add("Medical condition with yellowing of the skin or whites of the eyes");
        temp.add("Eat more iron-riced food");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have pallor?");
        temp.add("An unhealthy pale appearance");
        temp.add("You should go to the doctor");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have edema?");
        temp.add("Edema is observable swelling from fluid accumulation in body tissues");
        temp.add("Edema is a loss of salts and protein so you need eat food that contains them but not so much");
        this.questions.add(temp);
        break;
      case 4:
        count=5;
        this.name="Skin manifestation";
        temp=new List();
        temp.add("Do you have acne?");
        temp.add("Skin condition characterized by red pimples on the skin, especially on the face");
        temp.add("You need to take care of your hygiene and put some ointments");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have skin redness?");
        temp.add("Your skin tends to be red not the pure red but the first degree of the red");
        temp.add("1- Figure out what environmental and lifestyle stressors negatively impact your complexion.\n2- Limit exposure to irritants");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have ulcers?");
        temp.add("An open sore on an external or internal surface of the body, caused by a break in the skin or mucous membrane which fails to heal");
        temp.add("Doing regular foot and ankle exercises can help strengthen your leg muscles and improve blood flow in your legs");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have nevus?");
        temp.add("A birthmark or a mole on the skin, especially a birthmark in the form of a raised red patch.");
        temp.add("It can be removed by some kind of operation");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have raised ulcers?");
        temp.add("An open sore on an external or internal surface of the body, caused by a break in the skin or mucous membrane which fails to heal");
        temp.add("Doing regular foot and ankle exercises can help strengthen your leg muscles and improve blood flow in your legs");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have skin rash?");
        temp.add("A rash is a change of the human skin which affects its color, appearance, or texture.");
        temp.add("1- Cold compress\n2- Oatmeal bath\n");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have itchiness?");
        temp.add("Itchiness - an irritating cutaneous sensation that produces a desire to scratch");
        temp.add("1- Avoid items or situations that cause you to itch.\n2- Moisturize daily. \n3- Use creams, lotions or gels that soothe and cool the skin. \n4- Avoid scratching whenever possible.\n5- Take a bath or shower.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have harshness?");
        temp.add("The quality of being unpleasantly rough or jarring to the senses.");
        temp.add("I have nothing for you sorry");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have scaling of skin?");
        temp.add("Scaly skin is a common symptom of dry skin and can occur anywhere on the body");
        temp.add("Scaling skin is treated with a topical cream you can pick up at the drugstore");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have peeling of skin?");
        temp.add("Peeling skin is unintended damage to and loss of the upper layer of your skin");
        temp.add("1- Avoid alchol\n2- Drink alot of water");
        this.questions.add(temp);
        break;
      case 5:
        count=3;
        this.name="Respiratory disorders";
        temp=new List();
        temp.add("Do you have dyspnea?");
        temp.add("Difficult or laboured breathing.");
        temp.add("Diet and exercise");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have tachypnea?");
        temp.add("Abnormally rapid breathing.");
        temp.add("You should act quickly when it happens again,call the ambulance immediately or seek any medical attention");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have wheezes?");
        temp.add("Breathe with a whistling or rattling sound in the chest, as a result of obstruction in the air passages.");
        temp.add("1- Drink warm liquids\n2- Inhale moist air.\n3- Eat more fruits and vegetables.\n4- Quit smoking.\n5- Try pursed lip breathing.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have dry cough?");
        temp.add("A dry cough is a cough where no phlegm or mucus is produced");
        temp.add("Dry coughs that are caused by a viral infection such as a cold usually get better on their own within a week or two.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have reproductive cough?");
        temp.add("Cough is when you have a cough that produces mucus or phlegm (sputum). You may feel congested and have a 'rattly' or 'tight'");
        temp.add("Treatments for a wet cough depend on what’s causing it. For the majority of wet coughs caused by a virus such as a cold or flu, treatment is unnecessary. Viruses must simply run their course.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have hemoptysis?");
        temp.add("The coughing up of blood.");
        temp.add("The most common reason for coughing up blood is acute bronchitis, which typically gets better on its own without treatment.");
        this.questions.add(temp);
        break;
      case 6:
        count=5;
        this.name="heart disorders";
        temp=new List();
        temp.add("Do you have dyspnea?");
        temp.add("Difficult or laboured breathing.");
        temp.add("Diet and exercise");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have palpitations and pounding in chest?");
        temp.add("Palpitations make you feel like your heart is beating too hard or too fast, skipping a beat");
        temp.add("Palpitations that are infrequent and last only a few seconds usually don't need to be evaluated but if you have heart disease you should go to the doctor");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have arrhythmia?");
        temp.add("An arrhythmia is an uneven heartbeat,rapid or irregular heart beats");
        temp.add("Seek urgent medical care if you suddenly experience any of these signs : shortness of breath, weakness, dizziness, lightheadedness, fainting or near fainting, and chest pain or discomfort.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have chest pain referring to arms?");
        temp.add("A pain in your chest and in your arm");
        temp.add("Simultaneous chest and arm pain could be signs of a muscle strain or a heart attack If the pain is a burning sensation during or after a meal, it may be heartburn. If the pain worsens with movement or when lifting something, it could be muscular Otherwise, consider a pressure or tightness in your chest and pain or heaviness in your arms as possible heart attack symptoms and get medical attention immediately.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have heartburn?");
        temp.add("A form of indigestion felt as a burning sensation in the chest, caused by acid regurgitation into the oesophagus(the part of the alimentary canal which connects the throat to the stomach).");
        temp.add("1- Wearing loose clothing.\n2- Standing up straight.\n3- Elevating your upper body.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have headache?");
        temp.add("A continuous pain in the head.");
        temp.add("1- Rest in a quiet, dark room.\n2- Hot or cold compresses to your head or neck.\n3- Massage and small amounts of caffeine.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have fever?");
        temp.add("Simply referring to a rise of body temperature above normal");
        temp.add("1- Give them a slightly warm bath\n2- Place a cool, damp washcloth on their forehead\n3- Wash their arms and body with a cool cloth ");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have weakness and fatigability?");
        temp.add("Weakness refers to a decrease in muscle strength. Fatigue is tiredness that may be either independent of, or associated with, exertion.");
        temp.add("1- Limit medicines that might contribute to fatigue.\n2- Improve your diet.\n3- Reduce your use of alcohol or other drugs\n4- Cut back on watching television.\n5- Get a good night's sleep.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have dizziness?");
        temp.add("Dizziness that creates the false sense that you or your surroundings are spinning or moving");
        temp.add("1- Lie down until dizziness passes, then get up slowly.\n2- Dove slowly and carefully.\n3- Get plenty of rest.\n4- Drink plenty of fluids, especially water.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have lack of energy?");
        temp.add("Always Being too tired abnormally");
        temp.add("1- Eat often to beat tiredness.\n2- Get moving.\n3- Lose weight to gain energy.\n4- Sleep well.\n5- Reduce stress to boost energy. ...");
        this.questions.add(temp);
        break;
      case 7:
        this.count=3;
        this.name="COVID-19";
        temp=new List();
        temp.add("Do you have cough?");
        temp.add("A cough is your body's way of responding when something irritates your throat or airways.");
        temp.add("Drink alot of warm drinks");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have fever?");
        temp.add("Simply referring to a rise of body temperature above normal");
        temp.add("1- Give them a slightly warm bath\n2- Place a cool, damp washcloth on their forehead\n3- Wash their arms and body with a cool cloth ");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have Difficulty in breathing?");
        temp.add("You have some difficulty in breathing");
        temp.add("1- Drink alot of coffee\n2- Use fan");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have pain in throat?");
        temp.add("A sore throat is pain, scratchiness or irritation of the throat that often worsens when you swallow.");
        temp.add("1- Try comforting foods and beverage.\n2- Gargle with saltwater.");
        this.questions.add(temp);
        temp=new List();
        temp.add("Do you have tirdness?");
        temp.add("The state of wishing for sleep or rest; weariness.");
        temp.add("1- Eat often to beat tiredness\n2- Lose weight to gain energy \n3- Sleep well");
        this.questions.add(temp);
        break;
    }
  }

}