class QuizzModel {
  /// Propriedades intrínsecas ao model
  final String type;
  final String category;
  final String difficulty;
  final List<Question> questions;

  /// Controle de progresso
  int? totalQuestions;
  int? progress = 0;

  /// Controle de tempo
  DateTime? startAt;
  DateTime? endAt;

  QuizzModel({
    required this.type,
    required this.category,
    required this.difficulty,
    required this.questions,
  });

  /// Grava o início do quiz
  void start() {
    startAt = DateTime.now();
  }

  /// Grava o fim do quiz
  void end() {
    endAt = DateTime.now();
  }

  /// Retorna o tempo decorrido do quiz
  String? time() {
    if (startAt != null && endAt != null) {
      int duration = endAt!.difference(startAt!).inSeconds;

      int days = duration ~/ 86400;
      int hours = (duration % 86400) ~/ 3600;
      int minutes = (duration % 3600) ~/ 60;
      int seconds = duration % 60;

      List<String> parts = [];

      if (days > 0) parts.add('${days}d');
      if (hours > 0) parts.add('${hours}h');
      if (minutes > 0) parts.add('${minutes}m');
      if (seconds > 0) parts.add('${seconds}s');

      if (parts.isEmpty) parts.add('0s');

      return parts.join(' ');
    }

    return null;
  }

  factory QuizzModel.fromJson(Map<String, dynamic> json) {
    return QuizzModel(
      type: json['results'][0]['type'],
      category: json['results'][0]['category'],
      difficulty: json['results'][0]['difficulty'],
      questions: List<Question>.from(
        json['results'].map((q) => Question.fromJson(q)),
      ),
    );
  }
}

class Question {
    final String question;
    final List<String> options;
    final String answer;

    Question({
      required this.question,
      required this.options,
      required this.answer,
    });

    factory Question.fromJson(Map<String, dynamic> json) {
      return Question(
        question: json['question'],
        options: List<String>.from(json['incorrect_answers']),
        answer: json['correct_answer'],
      );
    }
  }