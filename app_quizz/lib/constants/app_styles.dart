import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  
  static final TextStyle titleLarge = GoogleFonts.atma(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle titleMedium = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle titleSmall = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle googleButton = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bodyText = GoogleFonts.inter(
    fontSize: 16,
  );

  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.greyCaption,
  );

  static final TextStyle captionActive = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static final TextStyle option = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.greyCaption,
  );
}

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey1 = Color(0xFF8C8E9C);
  static const Color grey2 = Color(0xFF12141D);
  static const Color grey3 = Color(0xFF10111A);
  static const Color greyCaption = Color(0xFF757575);
  static const Color greyButton = Color.fromARGB(255, 48, 48, 70);

  static const Color yellow = Color(0xFFFE9A00);
  static const Color orange = Color(0xFFE17100);
  static const Color green = Color(0xFF009966);
  static const Color pink = Color(0xFFE12AFB);
  static const Color purple = Color(0xFF615FFF);
  static const Color blue = Color(0xFF2B7FFF);
  static const Color onError = Color(0xFFFF2056);

  static const Color avatarBackground = Color.fromARGB(255, 43, 39, 116);
  static const Color surfaceInput = Color(0xFF292B3D);
  static const Color textInput = Color(0xFF8C8E9C);
  static const Color borderInput = Color.fromARGB(255, 58, 60, 70);

  static const Color primary = Color(0xFF7A6EFF);
  static const Color secondary = Color(0xFF8C8E9C);

  static const Color scaffoldDarkBackgroundColor = Color(0xFF05050D);
}