import 'package:app_quizz/components/widgets.dart';
import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryViewModel(),
      child: Builder(builder: (context) {
        final viewModel = context.watch<HistoryViewModel>();
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 128.0, bottom: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('History', style: AppStyles.titleMedium),
                          Text('Your quizzes taken', style: AppStyles.caption),
                        ],
                      ),
                      SizedBox(height: 16),
                      RowCards(
                        cards: [
                          CardSmall(icon: IconAvatar(icon: LucideIcons.calendar, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground), mainText: '6', secondaryText: 'Quizzes'),
                          CardSmall(icon: IconAvatar(icon: LucideIcons.trendingUp, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground), mainText: '75%', secondaryText: 'Average'),
                          CardSmall(icon: IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground), mainText: '12.000', secondaryText: 'Points'),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(spacing: 8,
                        children: [
                          CardBig(icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary), title: 'Games',),
                          CardBig(icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary), title: 'Games',),
                          CardBig(icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary), title: 'Games',),
                          CardBig(icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary), title: 'Games',),
                          CardBig(icon: IconAvatar(icon: LucideIcons.gamepad2, colorIcon: AppColors.white, colorBackground: AppColors.primary), title: 'Games',),
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