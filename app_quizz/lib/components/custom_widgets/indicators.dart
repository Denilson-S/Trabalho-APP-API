import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Indicators extends StatelessWidget {
  final String time;
  final String corrects;
  final String wrongs;

  const Indicators({super.key, required this.time, required this.corrects, required this.wrongs});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(LucideIcons.clock, size: 12, color: AppColors.greyCaption),
        SizedBox(width: 4),
        Text(time, style: AppStyles.caption),
        SizedBox(width: 8),
        Icon(LucideIcons.checkCircle, size: 12, color: AppColors.green),
        SizedBox(width: 4),
        Text(corrects, style: AppStyles.caption),
        SizedBox(width: 8),
        Icon(LucideIcons.xCircle, size: 12, color: AppColors.onError),
        SizedBox(width: 4),
        Text(wrongs, style: AppStyles.caption),
      ],
    );
  }
}
