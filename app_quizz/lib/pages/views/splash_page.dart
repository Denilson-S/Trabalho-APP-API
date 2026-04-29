import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final userStorage = UserStorage();
    final token = await userStorage.getAccessToken();

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // Seu Logo aqui
          Text("Quiz Master", style: AppStyles.titleLarge),
          SizedBox(height: 24),
          CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}