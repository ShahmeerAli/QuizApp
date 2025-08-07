import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizapp/WelcomeScreen.dart';

class ProfileScreen extends StatefulWidget{

  final User? user;


  const ProfileScreen({super.key,this.user});

  @override
  State<StatefulWidget> createState()=>_ProfileState();

}

class _ProfileState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body:Container(
        decoration: BoxDecoration(

          gradient: LinearGradient(
              begin: Alignment.bottomRight,

              colors: [
            Color(0xfffff0ff),Color(0xffffffff),Color(0xff36d7ec)
          ])
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/man.png"),
            Text("${FirebaseAuth.instance.currentUser?.displayName}"),
            Text("${FirebaseAuth.instance.currentUser?.email}"),

            SizedBox(height: 15,width: double.infinity,),
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(onPressed: (){
                logoutGoogle();
              },style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                elevation: 5
              ), child: Text("Sign Out")),
            )
          ],
        ),
      ),
    );
  }

   Future<UserCredential?> logoutGoogle() async {


     try{
       await GoogleSignIn().signOut();
       await FirebaseAuth.instance.signOut();
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));


     }catch(e){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
        "${e.toString()}"
       )));
     }

   }

}