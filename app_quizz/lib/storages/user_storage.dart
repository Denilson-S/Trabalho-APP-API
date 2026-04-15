import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  Future<void> saveUserData(String userId, String userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userId, userData);
  }

  Future<String?> getUserData(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId);
  }

  Future<void> deleteUserData(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userId);
  }
}