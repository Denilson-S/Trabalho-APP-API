import 'package:flutter/material.dart';
import './pages/views/login_page.dart';
import './pages/views/home_page.dart';
import './pages/views/register_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String register = '/register';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginPage(),
      home: (context) => const MyHomePage(),
      register: (context) => const RegisterPage(),
    };
  }
}