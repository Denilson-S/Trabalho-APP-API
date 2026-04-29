import 'package:app_quizz/models/history_model.dart';
import 'package:app_quizz/models/quizz_model.dart';
import 'package:app_quizz/services/quizz_service.dart';
import 'package:flutter/material.dart';

class QuizzViewModel extends ChangeNotifier {

  final QuizzService _quizzService;

  QuizzViewModel(this._quizzService);

  final List<String> pages = ['/home', '/quizz_category', '/quizz_level', '/quizz'];
  
  String? _selectedCategory;
  String? _selectedLevel;
  List<QuizzModel> _quizzes = [];
  List<HistoryModel> _historyRecords = [];
  bool _isLoading = false;
  DateTime? _sessionStartTime;

  String? get selectedCategory => _selectedCategory;
  String? get selectedLevel => _selectedLevel;
  List<QuizzModel> get quizzes => _quizzes;
  List<HistoryModel> get historyRecords => _historyRecords;
  bool get isLoading => _isLoading;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setLevel(String level) {
    _selectedLevel = level;
    notifyListeners();
  }

  Future<void> fetchQuizzes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _quizzes = await _quizzService.getQuizzes(
        category: _selectedCategory,
        level: _selectedLevel,
      );
      
      _sessionStartTime = DateTime.now();

      // Inicializa a lista de histórico para as novas questões
      _historyRecords = _quizzes.map((q) => HistoryModel(
        userId: 0, 
        startTime: _sessionStartTime,
        endTime: null,
        quizz: q,
        category: q.category,
        level: q.level,
      )).toList();

    } catch (e) {
      print('Error fetching quizzes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mantido para compatibilidade se necessário, mas o startTime agora é fixo no fetch
  void startQuestionTimer() {
    // _sessionStartTime já foi definido no fetchQuizzes
  }

  void recordAnswer(int questionIndex, String selectedOption) {
    if (questionIndex < 0 || questionIndex >= _historyRecords.length) return;

    final record = _historyRecords[questionIndex];
    
    // Atribui 50 pontos se a opção for correta
    if (selectedOption == record.quizz?.answer) {
      record.score = 50;
    } else {
      record.score = 0;
    }
    
    notifyListeners();
  }

  int getTotalScore() {
    return _historyRecords.fold(0, (sum, record) => sum + record.score);
  }

  Future<void> saveQuizzHistory() async {
    if (_historyRecords.isEmpty) return;
    
    final sessionEndTime = DateTime.now();
    for (var record in _historyRecords) {
      record.endTime = sessionEndTime;
    }

    var result = await _quizzService.saveHistory(_historyRecords);
    if (result['success']) {
      print('History saved successfully! User score: ${result['user_score']}');
    } else {
      print('Failed to save history.');
    }
  }

  void goBack(BuildContext context, int index) {
    if (index > 0 && index < pages.length) {
      Navigator.of(context).pushReplacementNamed(pages[index - 1]);
    }
  }

  void goForward(BuildContext context, int index) {
    if (index >= 0 && index < pages.length - 1) {
      Navigator.of(context).pushNamed(pages[index + 1]);
    }
  }
}