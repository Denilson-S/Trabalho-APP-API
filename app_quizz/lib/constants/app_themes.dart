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
        side: BorderSide(color: AppColors.borderInput, width: 2), // Borda visível
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


/*
rightness: Define se o esquema é claro (Brightness.light) ou escuro (Brightness.dark).

primary: Cor principal da interface (ex: AppBar, botões principais).

onPrimary: Cor do texto/ícone sobre a cor primary.

primaryContainer: Cor de fundo para elementos destacados do tema primário.

onPrimaryContainer: Cor do texto/ícone sobre o primaryContainer.

primaryFixed / primaryFixedDim: Usadas em temas dinâmicos para tons fixos do primário.

onPrimaryFixed / onPrimaryFixedVariant: Cor do texto/ícone sobre os tons fixos do primário.

secondary: Cor secundária para elementos de destaque secundário.

onSecondary: Cor do texto/ícone sobre a cor secondary.

secondaryContainer: Cor de fundo para elementos destacados do tema secundário.

onSecondaryContainer: Cor do texto/ícone sobre o secondaryContainer.

secondaryFixed / secondaryFixedDim: Tons fixos do secundário.

onSecondaryFixed / onSecondaryFixedVariant: Cor do texto/ícone sobre tons fixos do secundário.

tertiary: Terceira cor de destaque (opcional).

onTertiary: Cor do texto/ícone sobre a cor tertiary.

tertiaryContainer: Cor de fundo para elementos destacados do tema terciário.

onTertiaryContainer: Cor do texto/ícone sobre o tertiaryContainer.

tertiaryFixed / tertiaryFixedDim: Tons fixos do terciário.

onTertiaryFixed / onTertiaryFixedVariant: Cor do texto/ícone sobre tons fixos do terciário.

error: Cor para indicar erros.

onError: Cor do texto/ícone sobre a cor error.

errorContainer: Cor de fundo para elementos de erro.

onErrorContainer: Cor do texto/ícone sobre o errorContainer.

surface: Cor de fundo para superfícies (cards, sheets, etc).

onSurface: Cor do texto/ícone sobre a cor surface.

surfaceDim / surfaceBright: Variações de brilho da superfície.

surfaceContainerLowest/Low/High/Highest: Tons para containers em diferentes níveis de elevação.

surfaceContainer: Cor de container de superfície padrão.

onSurfaceVariant: Cor do texto/ícone sobre variantes de superfície.

outline: Cor para linhas de contorno/divisores.

outlineVariant: Variante da cor de contorno.

shadow: Cor de sombra.

scrim: Cor para sobreposição de fundo (ex: modal).

inverseSurface: Cor de superfície invertida (usada em temas escuros).

onInverseSurface: Cor do texto/ícone sobre a inverseSurface.

inversePrimary: Cor primária invertida.

surfaceTint: Cor de destaque para superfícies.

background: Cor de fundo geral da aplicação.

onBackground: Cor do texto/ícone sobre o background.

surfaceVariant: Variante da cor de superfície.
*/