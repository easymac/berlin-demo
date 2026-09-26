import 'package:flutter/material.dart';

const _seedColor = Color(0xFF1B5FD9);
const _accentColor = Color(0xFF12A4B5);
const _backgroundColor = Color(0xFFEDEFF5);

ThemeData buildTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    primary: _seedColor,
    tertiary: _accentColor,
    surface: _backgroundColor,
    surfaceContainerLowest: Colors.white,
  );
  final base = ThemeData(
    colorScheme: colorScheme,
    typography: Typography.material2021(
      colorScheme: colorScheme,
      // Material's letter spacing is tuned for Roboto. San Francisco, the iOS
      // system font, already adjusts its tracking for each size.
      englishLike: Typography.englishLike2021.apply(letterSpacingFactor: 0),
    ),
  );
  final textTheme = base.textTheme;

  return base.copyWith(
    appBarTheme: const AppBarThemeData(
      centerTitle: false,
      scrolledUnderElevation: 1,
      shadowColor: Colors.black26,
    ),
    textTheme: textTheme.copyWith(
      headlineMedium: textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w800,
      ),
      titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      titleMedium: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surfaceContainerLowest,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    badgeTheme: BadgeThemeData(
      backgroundColor: colorScheme.inverseSurface,
      textColor: colorScheme.onInverseSurface,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
  );
}
