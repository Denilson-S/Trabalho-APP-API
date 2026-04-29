import './constants/app_themes.dart';
import 'package:flutter/material.dart';
import './routes.dart';

final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
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
    );
  }
}