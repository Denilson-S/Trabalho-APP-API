import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgText extends StatelessWidget {
  final String path;
  final String text;

  const SvgText({super.key, required this.path, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(path, height: 24.0, width: 24.0,),
        const SizedBox(width: 8),
        Text(text, style: AppStyles.googleButton),
      ],
    );
}
}