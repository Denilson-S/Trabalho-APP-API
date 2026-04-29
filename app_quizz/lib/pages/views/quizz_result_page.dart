import 'package:app_quizz/components/widgets.dart';
import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/quizz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class QuizzResultPage extends StatefulWidget {
  const QuizzResultPage({super.key});

  @override
  State<QuizzResultPage> createState() => _QuizzResultPageState();
}

class _QuizzResultPageState extends State<QuizzResultPage> {
  
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizzViewModel>();
    
    final correctAnswers = viewModel.historyRecords.where((r) => r.score > 0).length;
    final totalQuestions = viewModel.historyRecords.length;
    final wrongAnswers = totalQuestions - correctAnswers;
    final totalScore = viewModel.getTotalScore();
    final precision = totalQuestions > 0 ? (correctAnswers / totalQuestions * 100).toInt() : 0;
    
    String timeSpent = '0s';
    if (viewModel.historyRecords.isNotEmpty) {
      final first = viewModel.historyRecords.first;
      if (first.startTime != null && first.endTime != null) {
        final diff = first.endTime!.difference(first.startTime!);
        final minutes = diff.inMinutes;
        final seconds = diff.inSeconds % 60;
        timeSpent = minutes > 0 ? '${minutes}m ${seconds}s' : '${seconds}s';
      }
    }

    String resultMessage = 'Very Good!';
    if (precision < 40) {
      resultMessage = 'Keep practicing!';
    } else if (precision < 70) {
      resultMessage = 'Good job!';
    } else if (precision >= 90) {
      resultMessage = 'Excellent!';
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 128.0, bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 12,
                children: [
                  CircleButton(icon: LucideIcons.chevronLeft, onPressed: () => Navigator.of(context).pushReplacementNamed('/home')),
                ],
              ),
              IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground),
              Text(resultMessage, style: AppStyles.titleMedium),
              Text('Quiz finished!', style: AppStyles.caption ),
              SizedBox(height: 16),
              RowCards(
                cards: [
                  CardSmall(icon: IconAvatar(icon: LucideIcons.checkCircle2, colorIcon: AppColors.green, colorBackground: AppColors.avatarBackground), mainText: correctAnswers.toString(), secondaryText: 'Correct'),
                  CardSmall(icon: IconAvatar(icon: LucideIcons.xCircle, colorIcon: AppColors.onError, colorBackground: AppColors.avatarBackground), mainText: wrongAnswers.toString(), secondaryText: 'Wrong'),
                  CardSmall(icon: IconAvatar(icon: LucideIcons.timer, colorIcon: AppColors.blue, colorBackground: AppColors.avatarBackground), mainText: timeSpent, secondaryText: 'Time'),
                ],
              ),
              CardOption(rows: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      IconAvatar(icon: LucideIcons.star, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Points', style: AppStyles.caption,),
                        Text(totalScore.toString(), style: AppStyles.titleSmall)
                      ]),
                    ],),
                    Column( crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Precision', style: AppStyles.caption,),
                      Text('$precision%', style: AppStyles.titleSmall.copyWith(color: AppColors.green))
                    ],)
                  ],
                )
              ]),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.max,
                spacing: 16,
                children: [
                  Expanded(child: SecondaryButton(onPressed: () {
                    viewModel.fetchQuizzes().then((_) {
                      Navigator.of(context).pushReplacementNamed('/quizz');
                    });
                  }, text: 'Try Again')),
                  Expanded(child: PrimaryButton(onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                  }, text: 'Go to Home')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}