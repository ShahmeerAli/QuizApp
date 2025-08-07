
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/Questions.dart';

class Repository {


  Future<Map<dynamic?, dynamic>?> Scores() async {
    final user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseDatabase.instance.ref("User/${user?.uid}/score");
    final DataSnapshot snapshot = await ref.get();

    if (user == null) return null;

    if (snapshot.exists) {
      final scoresList = snapshot.value;
      if (scoresList is Map) {
        return scoresList.map((key, value) =>
            MapEntry((key.toString()), (value as Object)));
      }
    } else {
      print("No Scores Found");
    }
  }

  Future<List<Question>> loadQuestions(String category) async {
    final String jsonString = await rootBundle.loadString(
        "assets/quiz_questions.json");
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    print("category touched");
    print(jsonString);

    if (!jsonMap.containsKey(category)) {
      throw Exception("Category not found");
    }

    final List<dynamic> categoryData = jsonMap[category];

    return categoryData
        .map((e) => Question.fromJson(e as Map<String, dynamic>))
        .toList();
  }

}

  Future<void> GetSpecificDataandUpdate(String category,int score) async{
    final user=FirebaseAuth.instance.currentUser;
    if(user==null) return null;
    final ref=FirebaseDatabase.instance.ref("User/${user?.uid}/score/$category");


    final DataSnapshot snapshot= await ref.get();

    if(snapshot.exists){
      print("data fetched for category  : ${category}");
      int currentScore=snapshot.value as int;
      if (score > currentScore){
          currentScore=score;
          await ref.set(score);
      }

    }else{
      await ref.set(score);
      print("Score initialized to $score for category $category");

    }


  }


