import 'package:isar/isar.dart';

part 'quizz_model.g.dart';

@collection
class QuizzModel {
  Id id = 0;
  String? category;
  String? difficulty;
  List<Question>? questions;

  QuizzModel({
    this.category,
    this.difficulty,
    this.questions,
  });

  factory QuizzModel.fromJson(List<dynamic> jsonList) {
    if (jsonList.isEmpty) {
      throw ArgumentError('JSON list is empty');
    }
    return QuizzModel(
      category: jsonList[0]['quiz_category'],
      difficulty: jsonList[0]['quiz_level'],
      questions: List<Question>.from(
        jsonList.map((q) => Question.fromJson(q)),
      ),
    );
  }
}

@embedded
class Question {
  int? quizId;
  String? question;
  List<String>? options;
  String? answer;
  int score;

  Question({
    this.quizId,
    this.question,
    this.options,
    this.answer,
    this.score = 0,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      quizId: json['quiz_id'],
      question: json['quiz_question'],
      options: List<String>.from([
        json['quiz_option_i'], 
        json['quiz_option_ii'], 
        json['quiz_option_iii'], 
        json['quiz_answer']
      ]),
      answer: json['quiz_answer'],
    );
  }
}