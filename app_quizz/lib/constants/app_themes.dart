import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {

  static final ColorScheme colorDarkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF7A6EFF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF12141D),
    onSecondary: Color(0xFF8C8E9C),
    primaryContainer: Color(0xFFFFFFFFF),
    secondaryContainer: Color(0xFF8C8E9C),
    tertiaryContainer: Color(0xFF7A6EFF),
    error: Color(0xFF12141D),
    onError: Color(0xFFFF2056),
    surface: Color(0xFF1F2131),
    onSurface: Color(0xFFFFFFFF),
    shadow: Color(0xFF000000)
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: colorDarkScheme,
    primaryColor: colorDarkScheme.primary,
    scaffoldBackgroundColor: Color(0xFF05050D),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorDarkScheme.primary,
        foregroundColor: colorDarkScheme.onPrimary,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surfaceInput,
        foregroundColor: colorDarkScheme.onSecondary, // Texto e ícone com a cor primária
        side: BorderSide(color: AppColors.borderInput, width: 2),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceInput,
      hintStyle: AppStyles.bodyText.copyWith(color: AppColors.textInput),
      prefixIconColor: AppColors.textInput,
      suffixIconColor: AppColors.textInput,
      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: AppColors.borderInput, width: 2),
      ),
      
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: AppColors.onError, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: AppColors.onError, width: 2),
      ),

      errorStyle: AppStyles.caption.copyWith(color: AppColors.onError),
    ),

    cardTheme: CardThemeData(
      color: colorDarkScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    useMaterial3: true,
  );
}