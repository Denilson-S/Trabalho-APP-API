import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CardMedium extends StatelessWidget {
  final Widget icon;
  final String mainText;
  final String secondaryText;

  const CardMedium({super.key, required this.icon, required this.mainText, required this.secondaryText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mainText, style: AppStyles.titleSmall, overflow: TextOverflow.ellipsis),
                    Text(secondaryText, style: AppStyles.caption, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}