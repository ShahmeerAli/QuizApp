import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/OnBoardingItems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:quizapp/WelcomeScreen.dart';

class OnBoarding extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_MyOnboardingState();

}

class _MyOnboardingState extends State<OnBoarding>{
  final controller=OnBoardingItems();
  final pageController=PageController();
  bool isLastPage=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        bottomSheet:
        isLastPage ? getStarted() : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

                TextButton(onPressed: (){
                  pageController.nextPage(
                      duration: Duration(microseconds: 600), curve: Curves.easeIn);
                }, child: Text("Next",style: TextStyle(fontSize: 20),)),
              SmoothPageIndicator(controller: pageController, count: controller.items.length,effect: WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Colors.blueAccent
              ),)
            ],
          ),
        ),
     body: PageView.builder(
         onPageChanged:(index)=>setState(()=>isLastPage=controller.items.length-1==index),
         itemCount: controller.items.length,
         controller: pageController,
         itemBuilder: (context,index){
       return Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.asset(controller.items[index].image),
             Text(controller.items[index].title,style: TextStyle(fontSize: 25,color: Colors.blue),),
             Text(controller.items[index].description,style: TextStyle(fontSize: 20,color: Colors.blueGrey),)
           ],
         ),
       );

     })
    );

  }


  Widget getStarted(){
    return Container(
      width: 250,
      height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(onPressed: () async {
            final pres=await SharedPreferences.getInstance();
            pres.setBool("isOnboarding", true);
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
          }, style:ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,foregroundColor: Colors.white) ,child: Text(
            "Get Started",
            style: TextStyle(
              fontSize: 20
            ),
          )),
        ),
    );
  }
}