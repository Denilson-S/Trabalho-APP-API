import 'package:app_quizz/services/http_service.dart';
import 'package:dio/dio.dart';

class AuthService {
  final HttpService _http = HttpService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _http.post('/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        response.data['success'] = true;
        return response.data;
      }
    }on DioException catch (e) {
      // Captura o erro da API para ver o motivo da recusa
      print('Login Falhou - Status: ${e.response?.statusCode}');
      print('Detalhes: ${e.response?.data}');
    } catch (e) {
      print('Login Error: $e');
      
    }
    return {'success': false};
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await _http.post('/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 201) {
        response.data['success'] = true;
        return response.data;
      }
    } catch (e) {
      print('Register Error: $e');
    }
    return {'success': false};
  }

  Future<bool> logout() async {
    try {
      final response = await _http.post('/auth/logout');
      return response.statusCode == 200;
    } catch (e) {
      print('Logout Error: $e');
      return false;
    }
  }
}