import 'package:flutter/material.dart';

class QuizzViewModel extends ChangeNotifier {
  final List<String> pages = ['/home', '/quizz_category', '/quizz_level', '/quizz'];
  // Adicione suas variáveis e métodos aqui

  void goBack(BuildContext context, int index) {
    if (index > 0 && index < pages.length) {
      Navigator.of(context).pushReplacementNamed(pages[index - 1]);
    }
  }

  void goForward(BuildContext context, int index) {
    if (index >= 0 && index < pages.length - 1) {
      Navigator.of(context).pushNamed(pages[index + 1]);
    }
  }
}