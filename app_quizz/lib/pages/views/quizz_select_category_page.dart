import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/quizz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../components/widgets.dart';

class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({super.key});

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
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
                      CircleButton(icon: LucideIcons.chevronLeft, onPressed: () =>   viewModel.goBack(context, 1)),
                      Text('New Quiz', style: AppStyles.titleMedium),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Choose a category', style: AppStyles.titleMedium),
                      Text('Select the topic  of your quiz', style: AppStyles.caption),
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
                                icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary),
                                mainText: 'Games', secondaryText: '10 Questions',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 1))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary),
                                mainText: 'Games', secondaryText: '10 Questions',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 1))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary),
                                mainText: 'Games', secondaryText: '10 Questions',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 1))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary),
                                mainText: 'Games', secondaryText: '10 Questions',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 1))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary),
                                mainText: 'Games', secondaryText: '10 Questions',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 1))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary),
                                mainText: 'Games', secondaryText: '10 Questions',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 1))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary),
                                mainText: 'Games', secondaryText: '10 Questions',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 1))
                              ),
                            ],
                          ),
                          CardOption(
                            rows: [
                              RowOption(
                                icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary),
                                mainText: 'Games', secondaryText: '10 Questions',
                                trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.goForward(context, 1))
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