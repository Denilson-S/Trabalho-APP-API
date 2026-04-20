import 'package:app_quizz/components/custom_widgets/indicators.dart';
import 'package:app_quizz/components/custom_widgets/progress_bar.dart';
import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CardBig extends StatelessWidget {
  final Widget icon;
  final String title;

  const CardBig({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppStyles.titleSmall),
                  Indicators(time: '2:14', corrects: '10', wrongs: '2'),
                  ProgressBar(progress: 0.8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Today, 14:30', style: AppStyles.caption),
                      Text('+140 XP', style: AppStyles.captionActive),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}