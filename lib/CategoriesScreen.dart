
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/QuestionsScreen.dart';

class CategoryScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_CategoryState();
}


class _CategoryState extends State<CategoryScreen>{


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
      'category':'General Knowledge'
    },

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Categories",style: TextStyle(
          fontSize: 20,
          color: Colors.white          
        ),),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
             decoration: BoxDecoration(
               gradient: LinearGradient(colors: [
                 Color(0xffffffff),Color(0xffffffff)
               ])
             ),
             child: GridView.builder(gridDelegate:
             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: 10) ,
                 itemCount: dataCategories.length,
                 itemBuilder: (context,index){
                  final items=dataCategories[index];
                  return Card(
                    color: Colors.blue,
                    shadowColor: Color(0xff054d9f),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Image.asset(
                           width: 60,
                             height: 60,
                             items['image']!),
                         SizedBox(height: 10,),
                         InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsScreen(category: items['category']!)));
                           },
                           child: Text(
                             items['category']!,
                             style: TextStyle(
                               fontSize: 20,
                               color: Colors.white
                             ),
                           ),
                         )
                       ],
                    ),
                  );

             })
        ),
      ),
    );
  }



}