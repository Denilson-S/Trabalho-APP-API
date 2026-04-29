import 'package:isar/isar.dart';

part 'quizz_model.g.dart';

@embedded
class QuizzModel {
  int? id;
  String? category;
  String? level;
  String? language;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? answer;

  QuizzModel({
    this.id,
    this.category,
    this.level,
    this.language,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.answer,
  });

  factory QuizzModel.fromJson(dynamic json) {
    return QuizzModel(
      id: json['quiz_id'],
      category: json['quiz_category'],
      level: json['quiz_level'],
      language: json['quiz_language'],
      question: json['quiz_question'],
      option1: json['quiz_option_i'],
      option2: json['quiz_option_ii'],
      option3: json['quiz_option_iii'],
      answer: json['quiz_answer'],
    );
  }
}
