import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/quizz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../components/widgets.dart';

class SelectLevelPage extends StatefulWidget {
  const SelectLevelPage({super.key});

  @override
  State<SelectLevelPage> createState() => _SelectLevelPageState();
}

class _SelectLevelPageState extends State<SelectLevelPage> {
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 12,
                    children: [
                      CircleButton(icon: LucideIcons.chevronLeft, onPressed: () =>   viewModel.goBack(context, 2)),
                      Text('New Quiz', style: AppStyles.titleMedium),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Choose a difficulty', style: AppStyles.titleMedium),
                      Text('Select the difficulty level of your quiz', style: AppStyles.caption),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.angry, colorIcon: AppColors.white, colorBackground: AppColors.onError),
                                mainText: 'Hard',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 2))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.meh, colorIcon: AppColors.white, colorBackground: AppColors.yellow),
                                mainText: 'Medium',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 2))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.smile, colorIcon: AppColors.white, colorBackground: AppColors.green),
                                mainText: 'Easy',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 2))
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}