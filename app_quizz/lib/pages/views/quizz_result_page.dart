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
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 12,
                    children: [
                      CircleButton(icon: LucideIcons.chevronLeft, onPressed: () => {}),
                    ],
                  ),
                  IconAvatar(icon: LucideIcons.trophy, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground),
                  Text('Very Good!', style: AppStyles.titleMedium),
                  Text('Quiz finished!', style: AppStyles.caption ),
                  SizedBox(height: 16),
                  RowCards(
                    cards: [
                      CardSmall(icon: IconAvatar(icon: LucideIcons.checkCircle2, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground), mainText: '6', secondaryText: 'Correct'),
                      CardSmall(icon: IconAvatar(icon: LucideIcons.xCircle, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground), mainText: '4', secondaryText: 'Wrong'),
                      CardSmall(icon: IconAvatar(icon: LucideIcons.timer, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground), mainText: '1m 3s', secondaryText: 'Time'),
                    ],
                  ),
                  CardOption(rows: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          IconAvatar(icon: LucideIcons.star, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground),
                          SizedBox(width: 8),
                          Column(children: [
                            Text('Points', style: AppStyles.caption,),
                            Text('490', style: AppStyles.titleSmall)
                          ]),
                        ],),
                        Column( crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Precision', style: AppStyles.caption,),
                          Text('60%', style: AppStyles.titleSmall.copyWith(color: AppColors.green))
                        ],)
                      ],
                    )
                  ]),
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 16,
                    children: [
                      Expanded(child: SecondaryButton(onPressed: () {Navigator.of(context).pushNamed('/quizz');}, text: 'Try Again')),
                      Expanded(child: PrimaryButton(onPressed: () {Navigator.of(context).pushNamed('/home');}, text: 'Go to Home')),
                    ],
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