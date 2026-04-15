import 'dart:convert';
import '../models/quizz_model.dart';
import 'package:http/http.dart' as http;

class QuizzService {
  final String baseUrl;

  QuizzService({this.baseUrl = 'https://opentdb.com/api.php'});

  Future<QuizzModel?> fetchQuizz() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?amount=10&category=21&difficulty=medium&type=multiple'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        QuizzModel quizz = QuizzModel.fromJson(json);
        quizz.totalQuestions = quizz.questions.length;
        
        return quizz;
      }
    } catch (e) {
      print('Error fetching quiz: $e');
    }
    return null;
  }
}