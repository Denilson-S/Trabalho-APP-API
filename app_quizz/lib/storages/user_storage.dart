import 'package:app_quizz/models/player_model.dart';
import 'package:app_quizz/models/settings_model.dart';
import 'package:app_quizz/storages/local_storage.dart';
import 'package:isar/isar.dart';

class UserStorage {
  final _localStorage = LocalStorage();

  // Secure Storage (Tokens)
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _localStorage.writeSecure('access_token', accessToken);
    await _localStorage.writeSecure('refresh_token', refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _localStorage.readSecure('access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _localStorage.readSecure('refresh_token');
  }

  Future<void> deleteTokens() async {
    await _localStorage.deleteSecure('access_token');
    await _localStorage.deleteSecure('refresh_token');
  }

  // Isar Storage (Dados do usuario)
  Future<void> saveUserData(PlayerModel player) async {
    await _localStorage.writeTxn(() async {
      await _localStorage.isar.playerModels.put(player);
    });
  }

  Future<PlayerModel?> getUserData() async {
    return await _localStorage.isar.playerModels.where().findFirst();
  }

  Future<void> deleteUserData() async {
    await _localStorage.writeTxn(() async {
      await _localStorage.isar.playerModels.clear();
    });
  }

  // Isar Storage (Configurações)
  Future<void> saveSettings(SettingsModel settings) async {
    await _localStorage.writeTxn(() async {
      await _localStorage.isar.settingsModels.put(settings);
    });
  }

  Future<SettingsModel> getSettings() async {
    final settings = await _localStorage.isar.settingsModels.get(0);
    return settings ?? SettingsModel();
  }
}