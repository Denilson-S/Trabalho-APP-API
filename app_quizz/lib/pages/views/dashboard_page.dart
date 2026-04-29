import 'package:app_quizz/components/widgets.dart';
import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/dashboard_view_model.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  final UserStorage _userStorage = UserStorage();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardViewModel(context, _userStorage),
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
                      CustomAppBar(name: viewModel.user?.name ?? 'Player'),
                      SizedBox(height: 16),
                      RowCards(
                        cards: [
                          CardMedium(icon: IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.yellow, colorBackground: AppColors.white), mainText: viewModel.user?.score.toString() ?? '0', secondaryText: 'Score'),
                          CardMedium(icon: IconAvatar(icon: LucideIcons.target, colorIcon: AppColors.green, colorBackground: AppColors.white), mainText: viewModel.user?.totalQuizzes.toString() ?? '0', secondaryText: 'Quizzes')
                        ],
                      ),
                      PrimaryButton(onPressed: () {Navigator.of(context).pushNamed('/quizz_category');}, text: 'New Quiz'),
                      Text('Categories', style: AppStyles.titleMedium),
                      SizedBox(height: 4)
                    ],
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final List<String> items = ['Cinema', 'General Knowledge', 'Geography', 'History', 'Music', 'Science', 'Sport', 'TV series'];
                        final List<Color> colors = [AppColors.onError, AppColors.green, AppColors.blue, AppColors.orange, AppColors.purple, AppColors.yellow, AppColors.avatarBackground, AppColors.pink];
                        final List<IconData> icons = [LucideIcons.camera, LucideIcons.users, LucideIcons.globe2, LucideIcons.book, LucideIcons.headphones, LucideIcons.beaker, LucideIcons.bike, LucideIcons.tv2];
                        return SingleChildScrollView(
                          child: Column(
                            spacing: 8,
                            children: [
                              for (int i = 0; i < items.length; i += 2)
                                RowCards(
                                  cards: [
                                    CardMedium(
                                      icon: IconAvatar(icon: icons[i], colorIcon: AppColors.white, colorBackground: colors[i]),
                                      mainText: items[i],
                                      secondaryText: '20 quizzes'
                                    ),
                                    if (i + 1 < items.length)
                                      CardMedium(
                                        icon: IconAvatar(icon: icons[i + 1], colorIcon: AppColors.white, colorBackground: colors[i + 1]),
                                        mainText: items[i + 1],
                                        secondaryText: '19 quizzes'
                                      )
                                  ],
                                ),
                            ],
                          ),
                        );
                      }
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