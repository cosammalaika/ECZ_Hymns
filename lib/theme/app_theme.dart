import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0D4C63);
  static const Color primaryDeep = Color(0xFF08384A);
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFE2C47B);
  static const Color accentSoft = Color(0xFFF7F1DD);
  static const Color accentCool = Color(0xFFEAF2F7);
  static const Color outline = Color(0xFFE3EAF0);
  static const Color textPrimary = Color(0xFF163042);
  static const Color textSecondary = Color(0xFF667788);
  static const Color shadow = Color(0x140D4C63);
  static const Color success = Color(0xFF3D7D64);
}

class HymnsTheme {
  static ThemeData light() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      onPrimary: Colors.white,
      onSecondary: AppColors.primaryDeep,
      onSurface: AppColors.textPrimary,
      outline: AppColors.outline,
      surfaceTint: AppColors.surface,
    );

    final textTheme = Typography.blackMountainView.copyWith(
      headlineLarge: const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        height: 1.08,
      ),
      headlineMedium: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        height: 1.12,
      ),
      titleLarge: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.2,
      ),
      titleMedium: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.28,
      ),
      bodyLarge: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.75,
      ),
      bodyMedium: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
      labelLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),
      labelMedium: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.2,
      ),
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        },
      ),
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        toolbarHeight: 60,
        backgroundColor: AppColors.background.withOpacity(0.94),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.6,
        surfaceTintColor: AppColors.surface,
        shadowColor: AppColors.shadow,
        titleTextStyle: textTheme.titleLarge,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 22,
      ),
      dividerColor: AppColors.outline,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary.withOpacity(0.8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.2,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(AppColors.primary),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          textStyle: MaterialStatePropertyAll(textTheme.labelLarge),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? AppColors.primary
                : AppColors.surface,
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? Colors.white
                : AppColors.textPrimary,
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          side: const MaterialStatePropertyAll(
            BorderSide(color: AppColors.outline),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.accentCool,
        side: const BorderSide(color: Colors.transparent),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: AppColors.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
