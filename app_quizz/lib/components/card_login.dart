import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CardLogin extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const CardLogin({super.key, required this.title, required this.formKey, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: AppStyles.titleMedium),
            Padding(padding: const EdgeInsets.only(top: 40, bottom: 8, left: 8, right: 8),
              child: Form(
                key: formKey, 
                child: Column(
                  spacing: 12,
                  children: children
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}