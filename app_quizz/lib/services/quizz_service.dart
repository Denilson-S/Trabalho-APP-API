import 'package:app_quizz/models/history_model.dart';
import 'package:app_quizz/models/quizz_model.dart';
import 'package:app_quizz/services/http_service.dart';

class QuizzService {
  final HttpService _http = HttpService();

  Future<List<String>> getCategories() async {
    try {
      final response = await _http.get('/categories');
      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      }
    } catch (e) {
      print('Erro ao buscar categorias: $e');
    }
    return [];
  }

  /// Busca perguntas filtradas por categoria, nível e limite.
  /// O idioma é injetado automaticamente pelo interceptor do HttpService.
  Future<List<QuizzModel>> getQuizzes({String? category, String? level, int limit = 10}) async {
    try {
      final response = await _http.get('/quizzes', queryParameters: {
        if (category != null) 'category': category,
        if (level != null) 'level': level,
        'limit': limit,
      });
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => QuizzModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('Erro ao buscar quizzes: $e');
    }
    return [];
  }

  /// Salva o histórico de uma partida (conjunto de respostas).
  Future<Map<String, dynamic>> saveHistory(List<HistoryModel> records) async {
    try {
      final response = await _http.post('/history', data: records.map((e) => e.toJson()).toList());
      if (response.statusCode == 201) {
        return {
          'success': true,
          'user_score': response.data['user_score'],
          'history': response.data['history'],
        };
      }
    } catch (e) {
      print('Erro ao salvar histórico: $e');
    }
    return {'success': false};
  }

  /// Obtém o histórico completo do usuário logado, agrupado por partidas.
  Future<List<List<HistoryModel>>> getHistory() async {
    try {
      final response = await _http.get('/history');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((match) {
          return (match as List).map((item) => HistoryModel.fromJson(item)).toList();
        }).toList();
      }
    } catch (e) {
      print('Erro ao buscar histórico: $e');
    }
    return [];
  }

  /// Cria uma nova pergunta (Rota Admin).
  Future<bool> createQuiz(QuizzModel quiz) async {
    try {
      final response = await _http.post('/quizzes', data: {
        'level': quiz.level,
        'category': quiz.category,
        'language': quiz.language,
        'question': quiz.question,
        'option1': quiz.option1,
        'option2': quiz.option2,
        'option3': quiz.option3,
        'answer': quiz.answer,
      });
      return response.statusCode == 201;
    } catch (e) {
      print('Erro ao criar quiz: $e');
      return false;
    }
  }
}
