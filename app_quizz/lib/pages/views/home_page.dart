import 'package:app_quizz/components/app_widgets/navigation_bar.dart';
import 'package:app_quizz/pages/view_models/dashboard_view_model.dart';
import 'package:app_quizz/pages/view_models/history_view_model.dart';
import 'package:app_quizz/pages/view_models/home_view_model.dart';
import 'package:app_quizz/pages/view_models/settings_view_model.dart';
import 'package:app_quizz/pages/views/dashboard_page.dart';
import 'package:app_quizz/pages/views/history_page.dart';
import 'package:app_quizz/pages/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Builder(
        builder: (context) {
          final viewModel = context.watch<HomeViewModel>();
          return Scaffold(
            extendBody: true,
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                viewModel.setIndex(index); 
              },
              children: [
                ChangeNotifierProvider(
                  create: (_) => DashboardViewModel(),
                  child: const DashboardPage(),
                ),
                ChangeNotifierProvider(
                  create: (_) => HistoryViewModel(),
                  child: const HistoryPage(),
                ),
                ChangeNotifierProvider(
                  create: (_) => SettingsViewModel(),
                  child: const SettingsPage(),
                ),
              ],
            ),
            bottomNavigationBar: CustomNavigationBar(pageController: _pageController, viewModel: viewModel)
          );
        },
      ),
    );
  }
}