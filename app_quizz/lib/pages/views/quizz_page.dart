import 'package:app_quizz/components/widgets.dart';
import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/quizz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizzViewModel(),
      child: Builder(builder: (context) {
        final viewModel = context.watch<QuizzViewModel>();
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 128.0, bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 12,
                    children: [
                      CircleButton(icon: LucideIcons.chevronLeft, onPressed: () =>   viewModel.goBack(context, 3)),
                      Tag(text: '470', icon: LucideIcons.flame, color: AppColors.primary, backgroundColor: AppColors.avatarBackground)
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Question 7 of 10', style: AppStyles.caption),
                      Row(
                        children: [
                          Icon(LucideIcons.timer, size: 16.0, color: AppColors.primary),
                          const SizedBox(width: 4.0),
                          Text('57s', style: AppStyles.captionActive),
                        ],
                      ),
                    ],
                  ),
                  ProgressBar(progress: 0.7, color: AppColors.primary),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Tag(text: 'Game', icon: LucideIcons.gamepad2, color: AppColors.white, backgroundColor: AppColors.primary),
                      Tag(text: 'Hard', icon: LucideIcons.flame, color: AppColors.white, backgroundColor: AppColors.onError),
                    ],
                  ),
                  SizedBox(height: 4),
                  CardOption(
                    rows: [
                      Text('What is the principal person from GTA San Andreas?', style: AppStyles.titleSmall)
                    ],
                  ),
                  ColumnQuestion(questions: [], answer: 'answer'),
                  Spacer(),
                  PrimaryButton(onPressed: () {Navigator.of(context).pushNamed('/quizz_result');}, child: Text('Next Question')),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}