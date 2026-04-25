import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {

  static final ColorScheme colorDarkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.grey2,
    onSecondary: AppColors.white,
    primaryContainer: AppColors.white,
    secondaryContainer: AppColors.grey3,
    tertiaryContainer: AppColors.primary,
    error: AppColors.grey2,
    onError: AppColors.onError,
    surface: AppColors.surfaceInput,
    onSurface: AppColors.white,
    shadow: AppColors.black
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: colorDarkScheme,
    primaryColor: colorDarkScheme.primary,
    scaffoldBackgroundColor: AppColors.scaffoldDarkBackgroundColor,

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
        foregroundColor: colorDarkScheme.onSecondary,
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

  static final ColorScheme colorLightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.grey2,
    onSecondary: AppColors.grey3,
    primaryContainer: AppColors.white,
    secondaryContainer: AppColors.grey3,
    tertiaryContainer: AppColors.primary,
    error: AppColors.grey2,
    onError: AppColors.onError,
    surface: AppColors.surfaceInput,
    onSurface: AppColors.white,
    shadow: AppColors.black
  );

  static final ThemeData lightTheme = ThemeData(

    useMaterial3: true,
  );
}