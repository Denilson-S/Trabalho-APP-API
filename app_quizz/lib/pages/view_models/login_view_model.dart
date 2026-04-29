import 'package:app_quizz/models/player_model.dart';
import 'package:app_quizz/services/auth_service.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends ChangeNotifier {

  final AuthService _authService;
  final UserStorage _userStorage;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginViewModel(BuildContext context, this._authService, this._userStorage);

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
          name: userData['name'],
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
          name: userData['name'],
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

  Future<void> googleLogin(BuildContext context) async {
    try {
      // O serverClientId (ID Web) para que o Android gere o idToken corretamente.
      await _googleSignIn.initialize(
        serverClientId: '913171375876-mv6bqkltnioubeaeo2ldurhrqh50dccs.apps.googleusercontent.com',
      );

      // ignore: unnecessary_nullable_for_final_variable_declarations
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken != null) {
        Map<String, dynamic> response = await _authService.googleLogin(idToken);

        if (response['success']) {
          final userData = response['user'];
          final player = PlayerModel(
            name: userData['name'],
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
              SnackBar(content: Text('Erro no login com Google: ${response['error'] ?? 'Erro no servidor'}')),
            );
          }
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao conectar com Google: $error')),
        );
      }
    }
  }

  // Navigation
  void navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}