import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user_prefs', userData.entries.map((e) => '${e.key}:${e.value}').toList());
  }

  Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refresh_token', token);
  }

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataList = prefs.getStringList('user_prefs');

    if (userDataList != null) {
      return Map.fromEntries(userDataList.map((e) {
        final parts = e.split(':');
        return MapEntry(parts[0], parts[1]);
      }));
    }
    return null;
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> deleteUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_prefs');
  }

  Future<void> deleteTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('refresh_token');
    await prefs.remove('access_token');
  }
}