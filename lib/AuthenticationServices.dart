import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizapp/BottomNavigationScreen.dart';
import 'package:quizapp/DashBoard.dart';


class AuthenticationServices {
  final _auth = FirebaseAuth.instance;
  final   DatabaseReference _database=FirebaseDatabase.instance.ref();

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {
    try{

      final googleUser = await GoogleSignIn().signIn();
      final googleAuth=await googleUser?.authentication;

      if (googleUser == null) return null;

      final credentials=GoogleAuthProvider.credential(idToken:
      googleAuth?.idToken,accessToken:googleAuth?.accessToken );



      final usercrend=await _auth.signInWithCredential(credentials);

      User? user=usercrend?.user;


      if(user==null){
        String? id=user?.uid;
        String? email=user?.email;
        String? username=user?.displayName;

        await _database.child("User").child(id!).set({
          "name":username,
          "email":email,
          "score":{
            "Biology": 0,
            "Chemistry": 0,
            "Physics": 0,
            "Science": 0,
            "FootBall": 0,
            "HollyWood": 0,
            "BollyWood": 0,
            "Fashion": 0,
            "Music": 0,
            "Arts": 0,
            "Cricket": 0,
            "Geography": 0,
            "GeneralKnowledge": 0,
            "Language":0,
            "History":0,
            "Medical":0
          },
          "createdAt": DateTime.now().toIso8601String(),
        });

      }


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign In Successful!"))
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigationScreen(user: user)));

      return usercrend;


    }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
    }

  }


}