import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String userName;
  
  const UserAvatar({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.primary,
      child: Text(userName[0], style: AppStyles.titleMedium, overflow: TextOverflow.ellipsis),
    );
  }
}