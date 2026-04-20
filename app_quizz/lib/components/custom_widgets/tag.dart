import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final String text;
  final IconData? icon;

  const Tag({super.key, required this.text, required this.color, required this.backgroundColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: icon != null ? Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.0, color: color),
          const SizedBox(width: 8.0),
          Text(text, style: AppStyles.titleSmall.copyWith(color: color)),
        ],
      ) : Text(text, style: AppStyles.titleSmall.copyWith(color: color)),
    );
  }
}