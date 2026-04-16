import 'package:app_quizz/constants/app_defines.dart';
import 'package:dio/dio.dart';

class AuthService {
  final String apiUrl = AppDefines.apiUrl;
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post('$apiUrl/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        response.data['success'] = true;
        return response.data;
      }
    } catch (e) {
      print('Error: $e');
      return {'success': false};
    }
    return {'success': false};
  }

  Future<Map<String, dynamic>?> refreshToken(String token) async {
    try {
      final response = await _dio.post('$apiUrl/refresh-token',
        data: {
          'token': token,
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}