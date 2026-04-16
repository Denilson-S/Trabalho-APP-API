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
    Future.microtask(() => verifySession(context));
  }

  Future<void> verifySession(BuildContext context) async {
    // final refreshToken = await _userStorage.getRefreshToken();
    // if (refreshToken != null) {
    //   Map<String, dynamic>? response = await _authService.refreshToken(refreshToken);
    //   if (response != null && response['success']) {
    //     Navigator.pushNamed(context, '/home');
    //   }
    // }
    return;
  }

  // Password visibility toggle
  bool isObscure = true;
  void togglePasswordVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  // Credential validation
  Future<void> login(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {

      // Map<String, dynamic> response = await _authService.login(nameController.text, passwordController.text);

      // if (response['success']) {
      //   _userStorage.saveUserData(response['user']);
      //   _userStorage.saveTokens(response['access_token'], response['refresh_token']);
      //   Navigator.pushNamed(context, '/home');
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Login falhou: ${response['error']}')),
      //   );
      // }
      Navigator.pushNamed(context, '/home');
      return;
    }
  }

  void register(BuildContext context, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro realizado!')),
      );
      Navigator.pushNamed(context, '/home');
    }
  }

  void googleLogin(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login com Google realizado!')),
    );
  }

  // Navigation
  void navigateToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }
}