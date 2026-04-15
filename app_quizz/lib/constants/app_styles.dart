import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  
  static final TextStyle titleLarge = GoogleFonts.atma(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    // color: AppColors.primaryText, // Descomente quando a cor existir em AppColors
  );

  static final TextStyle titleMedium = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    // color: AppColors.primaryText,
  );

  static final TextStyle googleButton = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final TextStyle bodyText = GoogleFonts.inter(
    fontSize: 16,
    // color: AppColors.secondaryText,
  );

  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    color: Colors.grey[600],
  );

  static final TextStyle captionActive = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}

class AppColors {
  // As cores continuam como 'const' pois não dependem de pacotes externos
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey1 = Color(0xFF8C8E9C);
  static const Color grey2 = Color(0xFF12141D);
  static const Color grey3 = Color(0xFF10111A);

  static const Color surfaceInput = Color(0xFF292B3D);
  static const Color textInput = Color(0xFF8C8E9C);
  static const Color borderInput = Color.fromARGB(255, 58, 60, 70);

  static const Color onError = Color(0xFFFF2056);

  static const Color primary = Color(0xFF7A6EFF);
  static const Color secondary = Color(0xFF8C8E9C);
}