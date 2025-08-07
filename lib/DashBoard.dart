import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizapp/CategoriesScreen.dart';
import 'package:quizapp/ProfileScreen.dart';
import 'package:quizapp/QuestionsScreen.dart';


class DashBoard extends StatefulWidget{
  final User user;


  const DashBoard({Key? key,required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>_DashBoardState();

}


class _DashBoardState extends State<DashBoard>{
  List<String> quizQuotes = [
    "Knowledge is power. Quiz on!",
    "Your brain called – it wants more trivia!",
    "You miss 100% of the questions you don’t answer.",
    "Quiz mode: Activated. Let’s go!",
    "Don’t stop until you're proud.",
    "Every question is a step closer to genius.",
    "Think fast, answer faster!",
    "Right or wrong – you're still learning.",
    "Trust your gut... unless it’s math.",
    "Brains over luck – always.",
    "Your score doesn’t define your smarts.",
    "The more you quiz, the better you get!",
    "Leveling up your brain one question at a time.",
    "Even Google would be impressed!",
    "Be the quiz master you were born to be.",
    "Smash the question, own the scoreboard!",
    "This is your moment – make it count!",
    "Challenge accepted. Challenge conquered.",
    "Caution: Highly intelligent user detected.",
    "Trivia today, legend tomorrow."
  ];

  List<Map<String,String>> dataCategories=[
    {
      'image':'assets/images/science.png',
       'category':'Science'
    },
    {
      'image':'assets/images/biology.png',
      'category':'Biology'
    },
    {
      'image':'assets/images/physics.png',
      'category':'Physics'
    },
    {
      'image':'assets/images/chemistry.png',
      'category':'Chemistry'
    },
    {
      'image':'assets/images/art.png',
      'category':'Art'
    },
    {
      'image':'assets/images/fashion.png',
      'category':'Fashion'
    },
    {
      'image':'assets/images/cricket.png',
      'category':'Cricket'
    },
    {
      'image':'assets/images/football.png',
      'category':'Football'
    },
    {
      'image':'assets/images/hollywood.png',
      'category':'Hollywood'
    },
    {
      'image':'assets/images/bollywood.png',
      'category':'Bollywood'
    },
    {
      'image':'assets/images/music.png',
      'category':'Music'
    },
    {
      'image':'assets/images/globe.png',
      'category':'Geography'
    },
    {
      'image':'assets/images/gk.png',
      'category':'GeneralKnowledge'
    },

  ];


  @override
  Widget build(BuildContext context) {
    Random random=Random();
    String randomQuotes=quizQuotes[random.nextInt(quizQuotes.length)];
    return Scaffold(

      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffedf1f3),
                  Color(0xff81d9fa),
                  Color(0xfffcfcfc),
            ])
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h,width: double.infinity,),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shadowColor: Colors.deepOrangeAccent.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(user:widget.user,)));
                            print("Avatar tapped!");
                          },
                          borderRadius: BorderRadius.circular(20),
              
                          child: CircleAvatar(
                            radius: 30.r,
                            backgroundImage: AssetImage("assets/images/man.png"),
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Text("${widget.user.displayName!}",style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),),
              
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      height: 160.h,
                      child: Card(
                        shadowColor: Colors.deepOrangeAccent,
                        color: Color(0xfff56f65),
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      width: 60.w,
                                      height: 60.h,
                                      "assets/images/data_science.png"),
                                  SizedBox(width: 20,),
                                  Text(
                                    "Quote of the Day",style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                  ),
                                ],
                              ),
                            ),
              
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Text(
                                 randomQuotes,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
              
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quiz",style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w800
                        ),),
                        InkWell(
                          onTap: (){
                             Navigator.push(context,PageRouteBuilder(pageBuilder: (context,animation,secondaryanimation)=>CategoryScreen(),
                             transitionDuration: Duration(milliseconds: 400),
                             transitionsBuilder: (context,animation,secondaryanimation,child){
                               const begin=Offset(1.0,0.0);
                               const end=Offset.zero;
                               const curve=Curves.easeIn;
              
                               final tween=Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
                               final animationLoad=animation.drive(tween);
              
              
                               return SlideTransition(position: animationLoad,child: child,);
              
                             }));
                          },child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.blue,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        ),
                      ],
              
                    ),
                  ),
                  Container(
                      height: 100.h,
                    child:ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:dataCategories.length ,
                          itemBuilder: (context,index){
                            final items=dataCategories[index];
              
                            return Card(
                              color: Colors.white60,
                              shadowColor: Colors.blue,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Container(
                                height: 100.h,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
              
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsScreen(category: items['category']!)));
                                        },
                                        child: Image.asset(width: 50.w,height: 50.h,
                                            items['image']!),
                                      ),
                                      SizedBox(width: 15,),
                                      Text(items['category']!,style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.white
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
              
                  ),
                  SizedBox(height: 10.h,width: double.infinity,),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      child:
                        Column(
                          children: [
                            SizedBox(height: 10,width: double.infinity,),
                            Text("More Games",style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrangeAccent
                            ),),
                             SizedBox(height: 20.h,width: double.infinity,),
                            Card(
                              color: Colors.white,
                              elevation: 2,
                              shadowColor: Colors.deepOrangeAccent.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.r,
                                      backgroundImage: AssetImage("assets/images/language.png"),
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsScreen(category: 'Language')));
                                      },
                                      child: Text("Language",style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent
                                      ),),
                                    ),
              
                                  ],
                                ),
                              ),
                            ),
              
                            Card(
                              color: Colors.white,
                              elevation: 2,
                              shadowColor: Colors.deepOrangeAccent.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.r,
                                      backgroundImage: AssetImage("assets/images/column.png"),
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsScreen(category: 'History')));
                                      },
                                      child: Text("History",style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent
                                      ),),
                                    ),
              
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              elevation: 2,
                              shadowColor: Colors.deepOrangeAccent.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.r,
                                      backgroundImage: AssetImage("assets/images/hospital.png"),
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsScreen(category: 'Medical')));
                                      },
                                      child: Text("Medical",style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent
                                      ),),
                                    ),
              
                                  ],
                                ),
                              ),
                            ),
              
              
              
                          ],
                        )
                    ),
                  )
              
                ],
              ),
            ),

          ),
        ),
      ),

    );
  }


}