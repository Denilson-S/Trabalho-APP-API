import 'package:app_quizz/models/player_model.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  
  // Injeção de dependências
  final UserStorage _userStorage;

  // Variáveis de estado
  PlayerModel? user;

  DashboardViewModel(BuildContext context, this._userStorage){
    loadUserData();
  }

  Future<void> loadUserData() async {
    user = await _userStorage.getUserData();
    notifyListeners();
  }
}