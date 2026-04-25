import 'package:app_quizz/models/player_model.dart';
import 'package:app_quizz/services/auth_service.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {

  final AuthService _authService;
  final UserStorage _userStorage;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginViewModel(BuildContext context, this._authService, this._userStorage) {
    //Future.microtask(() => verifySession(context));
  }

  // Future<void> verifySession(BuildContext context) async {
  //   final refreshToken = await _userStorage.getRefreshToken();
  //   if (refreshToken != null) {
  //     Map<String, dynamic>? response = await _authService.refreshToken(refreshToken);
  //     if (response != null && response['success']) {
  //       Navigator.pushNamed(context, '/home');
  //     }
  //   }
  // }

  // Password visibility toggle
  bool isObscure = true;
  void togglePasswordVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  // Credential validation
  Future<void> login(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {

      Map<String, dynamic> response = await _authService.login(emailController.text, passwordController.text);

      if (response['success']) {
        final userData = response['user'];
        final player = PlayerModel(
          name: userData['name'], // Assuming API returns username
          email: userData['email'],
          score: userData['score'] ?? 0,
          totalQuizzes: userData['total_quizzes'] ?? 0,
        );
        
        await _userStorage.saveUserData(player);
        await _userStorage.saveTokens(response['accessToken'], response['refreshToken']);
        
        if (context.mounted) Navigator.pushNamed(context, '/home');
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login falhou: ${response['error'] ?? 'Erro desconhecido'}')),
          );
        }
      }
    }
  }

  Future<void> register(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> response = await _authService.register(nameController.text, emailController.text, passwordController.text);

      if (response['success']) {
        final userData = response['user'];
        final player = PlayerModel(
          name: userData['username'], // Assuming API returns username
          email: emailController.text,
          score: userData['score'] ?? 0,
          totalQuizzes: userData['total_quizzes'] ?? 0,
        );
        
        await _userStorage.saveUserData(player);
        await _userStorage.saveTokens(response['access_token'], response['refresh_token']);
        
        if (context.mounted) Navigator.pushNamed(context, '/home');
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registro falhou: ${response['error'] ?? 'Erro desconhecido'}')),
          );
        }
      }
    }
  }

  void googleLogin(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login com Google realizado!')),
    );
  }

  // Navigation
  void navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/');
  }
}