import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/Questions.dart';
import 'package:quizapp/RepositoryClass.dart';

import 'package:tuple/tuple.dart';



final ScoreslistProvider=Provider((ref)=>Repository());

final scoreProvider=FutureProvider<Map<dynamic?,dynamic>?>(
    (ref) async{
      final repo=ref.read(ScoreslistProvider);
      return await repo.Scores();
    }
);




final Questions=Provider((ref)=>Repository());

final QuestionsLoad=FutureProvider.family<List<Question>,String>(
    (ref,category)async  {
      final repoQuestions=ref.watch(Questions);
      return await repoQuestions.loadQuestions(category);
    }
);




final getScore=Provider((ref)=>Repository());

final getandUpdate=FutureProvider.family<void,Tuple2<String,int>>((ref,tuple) async {
   int score=tuple.item2;
   String category=tuple.item1;

   final repo=ref.watch(getScore);

   await GetSpecificDataandUpdate(category, score);

});






