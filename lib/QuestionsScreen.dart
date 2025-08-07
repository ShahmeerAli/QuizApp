import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/RepositoryClass.dart';
import 'package:quizapp/ViewModelClass.dart';
import 'package:tuple/tuple.dart';

final countIndex=StateProvider.autoDispose<int>((ref)=>0);

final TimerProvider=StateProvider.autoDispose<int>((ref)=>15);

final correctCount=StateProvider.autoDispose((ref)=>0);

final score=StateProvider.autoDispose((ref)=>0);

class QuestionsScreen extends ConsumerStatefulWidget{

  final String category;
  @override
  ConsumerState<QuestionsScreen> createState()=>_QuestionState();

  QuestionsScreen({required this.category});

}




class _QuestionState extends ConsumerState<QuestionsScreen>{


  static const maxSeconds=15;
  int? selectedIndex;


  Timer? timer;
  void startTimer(){
    timer?.cancel();

   ref.read(TimerProvider.notifier).state=maxSeconds;
   timer=Timer.periodic(Duration(seconds: 1), (time){
     final curentseconds=ref.read(TimerProvider);
     if(curentseconds==0){
       nextQuestion();

     }else{
       ref.read(TimerProvider.notifier).state--;
     }
   });

  }
  
  void nextQuestion(){
      ref.read(countIndex.notifier).state++;
      selectedIndex=null;
      startTimer(); // Restart timer for next question
    
  }

  @override
  void initState() {
    super.initState();
    startTimer();

  }


  void playsound(){
    final player=AudioPlayer();
    player.play(AssetSource('audio/buttonclick.mp3'));
    print("sound bt clicked");
  }


  @override
  Widget build(BuildContext context) {
    final countprovider=ref.watch(countIndex);
    final countdown=ref.watch(TimerProvider);
    final correctAns=ref.watch(correctCount);
    final maxScore=ref.watch(score);


    final questiondata=ref.watch(QuestionsLoad(widget.category));
    return Scaffold(
      body: Container(
        width: double.infinity,
         height: double.infinity,
         color: Colors.white,
         child: SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SizedBox(height: 40.h,width: double.infinity,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("${countdown}",style: TextStyle(fontSize: 20.sp,color: Colors.red),),
               ),
               SizedBox(height: 10.h,width: double.infinity,),
               questiondata.when(data: (questions){
                 if(countprovider >= questions.length){

                   String remarks=Remarks(maxScore);
                   timer?.cancel();
                   print("Calling getandUpdate with ${widget.category} and score $maxScore");
                   WidgetsBinding.instance.addPostFrameCallback((_){
                     GetSpecificDataandUpdate(widget.category, maxScore);
                   });

                   return  Container(
                     height:400.h,
                     width:320.w,
                     child: Card(
                       color: Colors.white,
                       shadowColor: Colors.lightBlue,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20.r)
                       ),
                       elevation: 5,
                       child: Column(
                         children: [
                           Center(child: Text("Quiz Complete",style: TextStyle(
                               fontSize: 25.sp,
                               fontWeight: FontWeight.w700,
                             color: Colors.blueGrey
                           ),)
                           ),
                           Lottie.asset("assets/lottie/result.json",width: 200.w),
                           Text("Correct Answers: ${correctAns} / 15",style: TextStyle(
                             fontSize: 20.sp,
                             color: Colors.blueGrey
                           ),),
                           Text("Score: ${maxScore} / 150",style: TextStyle(fontSize: 20.sp,color: Colors.blueGrey),),

                           Text("Remarks ",style: TextStyle(fontSize: 20.sp,color: Colors.blueGrey),),
                           Wrap(children: [Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Text(remarks,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: Colors.red),),
                           )])


                         ],
                       ),
                     ),
                   );


                 }

                 var q=questions[countprovider];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(

                    children: [

                      Container(
                        width: 350.w,
                        height: 140.h,
                        color: Colors.white,

                        child: Card(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(

                                children:[
                                  SizedBox(height: 5.h,width: double.infinity,),
                                  Center(child: Text("${q.question}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20.sp,color: Colors.white),)),]
                              ),
                            )),
                      ),
                      SizedBox(height: 20.sp,width: double.infinity,),
                      Column(

                        children: List.generate(q.options.length, (i)=>GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedIndex=i;
                              playsound();



                            });
                          },
                          child: Container(
                             width: 350.w,
                              height:60.h,
                              child: Card(
                                  color: selectedIndex == i ? Colors.greenAccent : Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(q.options[i],style: TextStyle(
                                          fontSize: 20.sp,color: Colors.blue
                                        ),),
                                      ),
                                    ],
                                  ))),
                        ),),
                      ),
                       SizedBox(height: 10.h,width: double.infinity,),
                      Container(
                        width: 200.w,
                        height: 40.h,
                        child: ElevatedButton(onPressed: (){
                          if(selectedIndex==q.answer){
                            ref.read(score.notifier).state+=10;
                            ref.read(correctCount.notifier).state++;
                          }
                          selectedIndex=null;
                         nextQuestion();
                        },style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white
                        ), child: Text("Next",style: TextStyle(
                          fontSize: 16.sp
                        ),)),
                      ),


                    ],
                  ),
                );
               }, error: (error,stackTrace){
                 return Text(error.toString());
               }, loading: ()=>Lottie.asset("assets/lottie/loadinganimation.json")

               )

             ],
           ),
         ),
      ),
    );
  }

  String Remarks(int score){

    String remarks;
    if(score<=50){
      remarks='Bro, even a wild guesser could’ve scored more. Legendary flop!';
    }else if(score>50 && score<=100){
      remarks="You passed... barely. This is what we call ‘survival mode";
    }else if(score>100 && score<=125){
      remarks="Not bad, not bad at all. Just a few brain cells away from glory";
    }else{
      remarks="Okay Einstein, leave some marks for the rest of us";
    }
    return remarks;
  }

  // Future<void> getandUpdate(String category, int maxscore) async{
  //   try {
  //     final repo = Repository(); // Or use your existing provider if you prefer
  //
  //     final currentScore = await repo.GetSpecificData(category);
  //     print("Function clicked");
  //
  //     final score = currentScore;
  //
  //     if (score == null) {
  //       print("Score is still loading or null, skipping update.");
  //       return;
  //     }
  //
  //     if (maxscore > score) {
  //       await repo.updateData(score, category);
  //     } else {
  //       print("No update needed. Current score: $score");
  //     }
  //
  //     print("✅ Function performed");
  //   } catch (e) {
  //     print("Exception: ${e.toString()}");
  //   }
  // }


}