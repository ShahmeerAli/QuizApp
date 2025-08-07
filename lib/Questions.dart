
class Question{
  String question;
  List<String>options;
  int answer;

  Question(
  {
    required this.question,required this.answer,required this.options
  }
      );



     factory Question.fromJson(
        Map<String,dynamic> json
      ){
       return Question(
         question: json['question'],
         options: List<String>.from(json['options']),
         answer:json['answer']
       );
     }



}