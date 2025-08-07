import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/ViewModelClass.dart';

class ScoresScreen extends ConsumerStatefulWidget{
  final User? user;

  const ScoresScreen({super.key,required this.user});

  @override
  ConsumerState<ScoresScreen> createState()=>_ScoresScreen();


}

class _ScoresScreen extends ConsumerState<ScoresScreen>{


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.refresh(scoreProvider);
    });
  }


  @override
  Widget build(BuildContext context) {
    final scores=ref.watch(scoreProvider);
    return Scaffold(

      backgroundColor: Colors.white,
         body: Padding(
           padding: const EdgeInsets.all(2.0),
           child: Container(
             width: double.infinity,
             height: double.infinity,
             decoration: BoxDecoration(
               gradient: LinearGradient(
                   begin: Alignment.topRight,
                   end: Alignment.bottomRight,
                   colors: [
                 Color(0xffffffff),Color(0xffffffff)
               ])
             ),
             child:Column(
               children: [
                 SizedBox(height: 30,width: double.infinity,),
                 Container(
                   width: double.infinity,
                   height: 200.h,
                   child: Card(
                     color: Color(0xfffdfdfd),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0)
                     ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            width: 100,
                              height: 100,
                              "assets/images/podium.png"),
                          Positioned(
                            child: Text("Rankings",style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey
                            ),),
                          )
                        ],

                      ),

                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20)
                     ),
                     child: Container(
                       width: double.infinity,
                       height: 50.h,
                       decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [
                           Color(0xff3085e1), Color(0xff179cb4),
                         ])
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("Score History",style: TextStyle(
                               fontWeight: FontWeight.w700,
                               color: Colors.white,
                               fontSize: 20.sp
                             ),),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
                 scores.when(data: (data){

                   final dataentry=data?.entries.toList();
                   if(dataentry==null){
                     return Center(
                       child: Text("Play Games to see Score",style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 20.sp,
                           color: Colors.red
                       ),),
                     );
                   }
                   return Expanded(
                     child: ListView.builder(
                       itemCount: dataentry?.length,
                         itemBuilder: (context,index){
                           final entry=dataentry?[index];

                            return Card(
                              color: Colors.white,
                              shadowColor: Colors.greenAccent,
                              elevation: 2,
                              child: ListTile(
                                leading: Text("${index +1}",style: TextStyle(fontSize: 20.sp,color: Colors.lightBlue),),
                                trailing: Text("${entry?.value} / 150",style: TextStyle(fontSize: 15.sp,color: Colors.red),),
                                title: Text("${entry?.key}",style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.blueGrey
                                ),),

                              ),
                            );
                         }),
                   );
                 },
                     error: (error,stackTrace){
                      return Text(
                        error.toString()
                      );
                 }, loading: ()=> Lottie.asset("assets/lottie/loadinganimation.json",width: 140.w,height: 140.h))

               ],
             )
           ),
         ),
    );
  }

}