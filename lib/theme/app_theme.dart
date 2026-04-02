import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const Color primary = Color(0xFF0D4C63);
  static const Color primaryDeep = Color(0xFF062F40);
  static const Color background = Color(0xFFEAF1F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFD1A04B);
  static const Color accentSoft = Color(0xFFF1E2BC);
  static const Color accentCool = Color(0xFFDDEAF2);
  static const Color outline = Color(0xFFC9D8E2);
  static const Color textPrimary = Color(0xFF163042);
  static const Color textSecondary = Color(0xFF50677A);
  static const Color shadow = Color(0x1C0D4C63);
  static const Color success = Color(0xFF3D7D64);
}

@immutable
class HymnsUiPalette extends ThemeExtension<HymnsUiPalette> {
  final bool isDark;
  final Color background;
  final Color surface;
  final Color surfaceSecondary;
  final Color outline;
  final Color textPrimary;
  final Color textSecondary;
  final Color shadow;

  const HymnsUiPalette({
    required this.isDark,
    required this.background,
    required this.surface,
    required this.surfaceSecondary,
    required this.outline,
    required this.textPrimary,
    required this.textSecondary,
    required this.shadow,
  });

  @override
  HymnsUiPalette copyWith({
    bool? isDark,
    Color? background,
    Color? surface,
    Color? surfaceSecondary,
    Color? outline,
    Color? textPrimary,
    Color? textSecondary,
    Color? shadow,
  }) {
    return HymnsUiPalette(
      isDark: isDark ?? this.isDark,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      outline: outline ?? this.outline,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  HymnsUiPalette lerp(ThemeExtension<HymnsUiPalette>? other, double t) {
    if (other is! HymnsUiPalette) {
      return this;
    }

    return HymnsUiPalette(
      isDark: t < 0.5 ? isDark : other.isDark,
      background: Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceSecondary:
          Color.lerp(surfaceSecondary, other.surfaceSecondary, t) ??
              surfaceSecondary,
      outline: Color.lerp(outline, other.outline, t) ?? outline,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      shadow: Color.lerp(shadow, other.shadow, t) ?? shadow,
    );
  }
}

extension HymnsThemeContext on BuildContext {
  HymnsUiPalette get hymnsPalette =>
      Theme.of(this).extension<HymnsUiPalette>()!;
}

class HymnsTheme {
  static const HymnsUiPalette _lightPalette = HymnsUiPalette(
    isDark: false,
    background: AppColors.background,
    surface: AppColors.surface,
    surfaceSecondary: AppColors.accentCool,
    outline: AppColors.outline,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    shadow: AppColors.shadow,
  );

  static const HymnsUiPalette _darkPalette = HymnsUiPalette(
    isDark: true,
    background: Color(0xFF091318),
    surface: Color(0xFF111E26),
    surfaceSecondary: Color(0xFF172933),
    outline: Color(0xFF28404D),
    textPrimary: Color(0xFFEAF3F8),
    textSecondary: Color(0xFFA3BAC5),
    shadow: Color(0x66000000),
  );

  static ThemeData light() {
    return _buildTheme(_lightPalette);
  }

  static ThemeData dark() {
    return _buildTheme(_darkPalette);
  }

  static ThemeData _buildTheme(HymnsUiPalette uiPalette) {
    final Brightness brightness =
        uiPalette.isDark ? Brightness.dark : Brightness.light;
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    ).copyWith(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: uiPalette.surface,
      onPrimary: Colors.white,
      onSecondary: uiPalette.textPrimary,
      onSurface: uiPalette.textPrimary,
      outline: uiPalette.outline,
      surfaceTint: Colors.transparent,
    );

    final textTheme = Typography.blackMountainView.copyWith(
      headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        color: uiPalette.textPrimary,
        height: 1.08,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: uiPalette.textPrimary,
        height: 1.12,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: uiPalette.textPrimary,
        height: 1.2,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: uiPalette.textPrimary,
        height: 1.28,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: uiPalette.textPrimary,
        height: 1.75,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: uiPalette.textSecondary,
        height: 1.6,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: uiPalette.textPrimary,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: uiPalette.textSecondary,
        letterSpacing: 0.2,
      ),
    );

    final base = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: uiPalette.background,
      canvasColor: uiPalette.background,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[uiPalette],
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
        backgroundColor: Colors.transparent,
        foregroundColor: uiPalette.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        systemOverlayStyle:
            uiPalette.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      iconTheme: IconThemeData(
        color: uiPalette.textPrimary,
        size: 22,
      ),
      dividerColor: uiPalette.outline,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: uiPalette.surface,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: uiPalette.textSecondary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(
            color: uiPalette.outline,
            width: 1.1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(
            color: uiPalette.outline,
            width: 1.1,
          ),
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
                : uiPalette.surfaceSecondary,
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? Colors.white
                : uiPalette.textPrimary,
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          side: MaterialStatePropertyAll(
            BorderSide(color: uiPalette.outline),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: uiPalette.surfaceSecondary,
        side: const BorderSide(color: Colors.transparent),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: uiPalette.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
