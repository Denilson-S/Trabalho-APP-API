import 'package:app_quizz/components/cards/row_cards.dart';
import 'package:app_quizz/components/custom_widgets/icon_avatar.dart';
import 'package:app_quizz/components/widgets.dart';
import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardViewModel(),
      child: Builder(builder: (context) {
        final viewModel = context.watch<DashboardViewModel>();
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 128.0, bottom: 24.0),
              child: Column(
                children: [
                  Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(name: 'Lucas'),
                      SizedBox(height: 16),
                      RowCards(
                        cards: [
                          CardMedium(icon: IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '12.600', secondaryText: 'Score'),
                          CardMedium(icon: IconAvatar(icon: LucideIcons.target, colorIcon: AppColors.green, colorBackground: AppColors.white), mainText: '47', secondaryText: 'Quizzes')
                        ],
                      ),
                      PrimaryButton(onPressed: () {Navigator.of(context).pushNamed('/quizz_category');}, text: 'New Quiz'),
                      Text('Categories', style: AppStyles.titleMedium),
                      SizedBox(height: 4)
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(spacing: 8,
                        children: [
                          RowCards(
                            cards: [
                              CardMedium(icon: IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '12.600', secondaryText: 'score'),
                              CardMedium(icon: IconAvatar(icon: LucideIcons.users, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '1.200', secondaryText: 'players')
                            ],
                          ),
                          RowCards(
                            cards: [
                              CardMedium(icon: IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '12.600', secondaryText: 'score'),
                              CardMedium(icon: IconAvatar(icon: LucideIcons.users, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '1.200', secondaryText: 'players')
                            ],
                          ),
                          RowCards(
                            cards: [
                              CardMedium(icon: IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '12.600', secondaryText: 'score'),
                              CardMedium(icon: IconAvatar(icon: LucideIcons.users, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '1.200', secondaryText: 'players')
                            ],
                          ),
                          RowCards(
                            cards: [
                              CardMedium(icon: IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '12.600', secondaryText: 'score'),
                              CardMedium(icon: IconAvatar(icon: LucideIcons.users, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: '1.200', secondaryText: 'players')
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}