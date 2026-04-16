import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class ActionText extends StatelessWidget {
  final String simpleText;
  final String actionText;
  final VoidCallback onPressed;

  const ActionText({super.key, required this.simpleText, required this.actionText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(simpleText, style: AppStyles.caption),
        GestureDetector(
          onTap: onPressed,
          child: Text(actionText, style: AppStyles.captionActive),
        ),
      ],
    );
  }
}