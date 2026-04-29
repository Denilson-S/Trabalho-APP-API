import 'package:app_quizz/models/quizz_model.dart';
import 'package:isar/isar.dart';

part 'history_model.g.dart';

@collection
class HistoryModel {
  Id id = Isar.autoIncrement;
  int userId;
  DateTime? startTime;
  DateTime? endTime;
  String? category;
  String? level;
  int score = 0;
  QuizzModel? quizz;

  HistoryModel({
    required this.userId,
    required this.startTime,
    required this.endTime,
    this.quizz,
    this.category,
    this.level,
  });

  void endQuiz(String option, int points) {
    if (option == quizz?.answer) score = points;
  }

  String time(){
    if (startTime != null && endTime != null) {
      final duration = endTime!.difference(startTime!);
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    }
    return 'N/A';
  }

  Map<String, dynamic> toJson() {
    return {
      "quizId": quizz?.id,
      "startTime": startTime?.toIso8601String(),
      "endTime": endTime?.toIso8601String(),
      "score": score
    };
  }

  factory HistoryModel.fromJson(dynamic json) {
    return HistoryModel(
      userId: json['user_id'],
      startTime: json['start_time'] != null ? DateTime.parse(json['start_time']) : null,
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      category: json['quiz_category'],
      level: json['quiz_level'],
    )..score = json['score'] ?? 0;
  }
}