import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/settings_view_model.dart';
import 'package:app_quizz/services/auth_service.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../components/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserStorage _userStorage = UserStorage();
  final AuthService _authService = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(context, _authService, _userStorage),
      child: Builder(builder: (context) {
        final viewModel = context.watch<SettingsViewModel>();
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 128.0, bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Settings', style: AppStyles.titleMedium),
                      Text('Manage your preferences', style: AppStyles.caption),
                    ],
                  ),
                  SizedBox(height: 16),
                  CardOption(
                    rows: [
                      RowOption(
                        icon: UserAvatar(userName: viewModel.user?.name ?? 'User'),
                        mainText: viewModel.user?.name ?? 'User', secondaryText: viewModel.user?.email ?? 'none',
                        trailing: CircleButton(icon: LucideIcons.logOut, onPressed: () => viewModel.logout(context)),
                      ),
                    ],
                  ),
                  CardOption(
                    rows: [
                      RowOption(
                        icon: IconAvatar(icon: LucideIcons.moon, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground),
                        mainText: 'Dark Theme', secondaryText: 'Activate night mode',
                        trailing: Switch(value: viewModel.settings?.isDarkMode ?? false, onChanged: viewModel.changeTheme)
                      ),
                      RowOption(
                        icon: IconAvatar(icon: LucideIcons.globe, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground),
                        mainText: 'Language', secondaryText: 'Change language', trailing: DropDownInput(options: ['English', 'Spanish', 'Portuguese'], onChange: (value) => viewModel.changeLanguage(value!)),
                      ),
                    ],
                  ),
                  CardOption(
                    rows: [
                      RowOption(
                        icon: IconAvatar(icon: LucideIcons.helpCircle, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground),
                        mainText: 'Help and Support', secondaryText: 'Help center',
                        trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.suport(context))
                      ),
                      RowOption(
                        icon: IconAvatar(icon: LucideIcons.star, colorIcon: AppColors.primary, colorBackground: AppColors.avatarBackground),
                        mainText: 'Rate the App', secondaryText: 'Leave your review',
                        trailing: CircleButton(icon: LucideIcons.chevronRight, onPressed: () => viewModel.rate(context))
                      ),
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