import 'package:app_quizz/pages/view_models/quizz_view_model.dart';
import 'package:app_quizz/services/quizz_service.dart';
import 'package:provider/provider.dart';

import './constants/app_themes.dart';
import 'package:flutter/material.dart';
import './routes.dart';

final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizzViewModel(QuizzService())),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeMode,
        builder: (context, currentTheme, child) {
          return MaterialApp(
            title: 'Quiz Master',
            themeMode: currentTheme,
            darkTheme: AppThemes.darkTheme,
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}