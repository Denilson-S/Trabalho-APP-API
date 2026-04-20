import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircleButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: AppColors.greyButton,
        child: Icon(icon, size: 20,)
      ),
    );
  }
}