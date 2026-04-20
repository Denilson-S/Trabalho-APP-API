import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  const CustomAppBar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary,
          child: Text(name[0], style: AppStyles.titleMedium),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello,', style: AppStyles.caption),
            Text(name, style: AppStyles.titleSmall),
          ],
        ),
      ],
    );
  }
}