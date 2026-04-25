import 'package:app_quizz/models/quizz_model.dart';
import 'package:isar/isar.dart';

part 'history_model.g.dart';

@collection
class HistoryModel {
  Id id = 0;
  final String level;
  final String category;
  DateTime? startTime;
  DateTime? endTime;
  int score = 0;
  int totalQuestions = 0;
  int correctQuestions = 0;
  final List<int>? quizzes_ids;

  HistoryModel({
    required this.level,
    required this.category,
    required this.startTime,
    required this.endTime,
    this.quizzes_ids,
  });

  void startQuiz() {
    startTime = DateTime.now();
  }

  void endQuiz() {
    endTime = DateTime.now();
  }

  String time(){
    if (startTime != null && endTime != null) {
      final duration = endTime!.difference(startTime!);
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    }
    return 'N/A';
  }

  List<dynamic> toJson() {
    return [
      quizzes?.map((q) => q.toJson())
    ];
  }

  factory HistoryModel.fromJson(List<dynamic> json) {
    return HistoryModel(
      level: json[0][0]['level'] as String,
      category: json[0][0]['category'] as String,
      startTime: json[0][0]['startTime'] != null
          ? DateTime.parse(json[0][0]['startTime'] as String)
          : null,
      endTime: json[0][0]['endTime'] != null
          ? DateTime.parse(json[0][0]['endTime'] as String)
          : null,
      quizzes: (json['quizzes'] as List<dynamic>?)
          ?.map((q) => QuizzModel.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }
}