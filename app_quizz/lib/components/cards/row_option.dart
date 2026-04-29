import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class RowOption extends StatelessWidget {
  final Widget icon;
  final String mainText;
  final String? secondaryText;
  final Widget trailing;

  const RowOption({super.key, required this.icon, required this.mainText, this.secondaryText, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: [
        Expanded(
          child: Row(
            children: [
              icon,
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mainText, style: AppStyles.titleSmall, overflow: TextOverflow.ellipsis),
                    if (secondaryText != null) Text(secondaryText!, style: AppStyles.caption, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
        trailing,
      ],
    );
  }
}