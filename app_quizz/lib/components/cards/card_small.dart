import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CardSmall extends StatelessWidget {
  final Widget icon;
  final String mainText;
  final String secondaryText;

  const CardSmall({super.key, required this.icon, required this.mainText, required this.secondaryText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              icon,
              const SizedBox(width: 8),
              Text(mainText, style: AppStyles.titleSmall),
              Text(secondaryText, style: AppStyles.caption),
            ],
          ),
        ),
      ),
    );
  }
}