import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String text;

  const CustomDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.borderInput, thickness: 1.5),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: AppStyles.caption,
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.borderInput, thickness: 1),
        ),
      ],
    );
  }
}