import 'package:app_quizz/models/player_model.dart';
import 'package:app_quizz/models/settings_model.dart';
import 'package:app_quizz/services/auth_service.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {

  // Injeção de dependências
  final AuthService _authService;
  final UserStorage _userStorage;

  // Variáveis de estado
  PlayerModel? user;
  SettingsModel? settings;

  SettingsViewModel(BuildContext context, this._authService, this._userStorage){
    loadUserAndSettingsData();
  }

  Future<void> loadUserAndSettingsData() async {
    user = await _userStorage.getUserData();
    settings = await _userStorage.getSettings();
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    bool success = await _authService.logout();

    if (success) {
      await _userStorage.deleteUserData();
      await _userStorage.deleteTokens();

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout falhou!')),
        );
      }
    }
  }

  Future<void> changeTheme(bool value) async {
    if (settings != null) {
      settings?.isDarkMode = !settings!.isDarkMode;
      await _userStorage.saveSettings(settings!);
      notifyListeners();
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    if (settings != null) {
      settings?.language = languageCode;
      await _userStorage.saveSettings(settings!);
      notifyListeners();
    }
  }

  Future<void> suport(BuildContext context) async {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Support ainda não foi implementado!')),
      );
    }
  }

  Future<void> rate(BuildContext context) async {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rate ainda não foi implementado!')),
      );
    }
  }
}