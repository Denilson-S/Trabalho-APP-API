import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomNavigationBar extends StatelessWidget {
  final PageController pageController;
  final HomeViewModel viewModel;

  const CustomNavigationBar({super.key, required this.pageController, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 80, right: 80, bottom: 24),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surfaceInput,
          border: Border.all(color: AppColors.black, width: 2),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(LucideIcons.home, 0, viewModel),
            _buildNavItem(LucideIcons.history, 1, viewModel),
            _buildNavItem(LucideIcons.settings, 2, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, HomeViewModel viewModel) {
    bool isSelected = viewModel.currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        viewModel.setIndex(index);
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7A68FA) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey.shade400,
          size: 24,
        ),
      ),
    );
  }
}