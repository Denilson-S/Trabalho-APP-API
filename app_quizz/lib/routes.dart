import 'package:app_quizz/pages/views/quizz_page.dart';
import 'package:app_quizz/pages/views/quizz_result_page.dart';
import 'package:app_quizz/pages/views/quizz_select_category_page.dart';
import 'package:app_quizz/pages/views/quizz_select_level_page.dart';
import 'package:app_quizz/pages/views/splash_page.dart';
import 'package:flutter/material.dart';
import './pages/views/login_page.dart';
import './pages/views/home_page.dart';
import './pages/views/register_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/';
  static const String home = '/home';
  static const String register = '/register';
  static const String quizzCategory = '/quizz_category';
  static const String quizzLevel = '/quizz_level';
  static const String quizz = '/quizz';
  static const String quizzResult = '/quizz_result';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashPage(),
      login: (context) => const LoginPage(),
      home: (context) => const MyHomePage(),
      register: (context) => const RegisterPage(),
      quizzCategory: (context) => const SelectCategoryPage(),
      quizzLevel: (context) => const SelectLevelPage(),
      quizz: (context) => const QuizzPage(),
      quizzResult: (context) => const QuizzResultPage(),
    };
  }
}