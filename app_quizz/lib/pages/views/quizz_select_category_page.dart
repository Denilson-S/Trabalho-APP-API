import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/quizz_view_model.dart';
import 'package:app_quizz/services/quizz_service.dart';
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

  final List<String> items = ['Cinema', 'General Knowledge', 'Geography', 'History', 'Music', 'Science', 'Sport', 'TV series'];
  final List<Color> colors = [AppColors.onError, AppColors.green, AppColors.blue, AppColors.orange, AppColors.purple, AppColors.yellow, AppColors.avatarBackground, AppColors.pink];
  final List<IconData> icons = [LucideIcons.camera, LucideIcons.users, LucideIcons.globe2, LucideIcons.book, LucideIcons.headphones, LucideIcons.beaker, LucideIcons.bike, LucideIcons.tv2];

  @override
  Widget build(BuildContext context) {
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
                  CircleButton(icon: LucideIcons.chevronLeft, onPressed: () => viewModel.goBack(context, 1)),
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
                    children: List.generate(items.length, (index) {
                      return CardOption(
                        rows: [
                          RowOption(
                            icon: IconAvatar(icon: icons[index], colorIcon: AppColors.white, colorBackground: colors[index]),
                            mainText: items[index],
                            secondaryText: '10 Questions',
                            trailing: CircleButton(
                              icon: LucideIcons.chevronRight,
                              onPressed: () {
                                viewModel.setCategory(items[index]);
                                viewModel.goForward(context, 1);
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}