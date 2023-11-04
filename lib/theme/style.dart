import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static const normal = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
  static const medium = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static const bold = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

final lightTextTheme = getTextTheme(isDark: false);
final darkTextTheme = getTextTheme(isDark: true);

TextStyle getBoldText(bool isDark) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: isDark ? Colors.white : Colors.black,
    fontSize: 18,
  );
}

TextStyle getNormalText(bool isDark) {
  return TextStyle(
    fontWeight: FontWeight.normal,
    color: isDark ? Colors.white : Colors.black,
    fontSize: 14,
  );
}

TextStyle getMediumText(bool isDark) {
  return TextStyle(
    fontWeight: FontWeight.w500,
    color: isDark ? Colors.white : Colors.black,
    fontSize: 16,
  );
}

TextTheme getTextTheme({required bool isDark}) {
  var bold = getBoldText(isDark);
  var medium = getMediumText(isDark);
  var normal = getNormalText(isDark);
  return TextTheme(
    bodyLarge: normal.copyWith(fontSize: AppFonts.f16),
    bodyMedium: normal.copyWith(fontSize: AppFonts.f14),
    bodySmall: normal.copyWith(fontSize: AppFonts.f12),
    displayLarge: medium.copyWith(fontSize: AppFonts.f22),
    displayMedium: medium.copyWith(fontSize: AppFonts.f18),
    displaySmall: medium.copyWith(fontSize: AppFonts.f14),
    labelLarge: normal.copyWith(fontSize: AppFonts.f18),
    labelMedium: normal.copyWith(fontSize: AppFonts.f16),
    labelSmall: normal.copyWith(fontSize: AppFonts.f14),
    titleLarge: medium.copyWith(fontSize: AppFonts.f18),
    titleMedium: medium.copyWith(fontSize: AppFonts.f16),
    titleSmall: medium.copyWith(fontSize: AppFonts.f14),
    headlineLarge: bold.copyWith(fontSize: AppFonts.f28),
    headlineMedium: bold.copyWith(fontSize: AppFonts.f24),
    headlineSmall: bold.copyWith(fontSize: AppFonts.f28),
  );
}

abstract class AppFonts {
  static const f8 = 8.0;
  static const f10 = 10.0;
  static const f12 = 12.0;
  static const f14 = 14.0;
  static const f16 = 16.0;
  static const f18 = 18.0;
  static const f20 = 20.0;
  static const f22 = 22.0;
  static const f24 = 24.0;
  static const f26 = 26.0;
  static const f28 = 28.0;
  static const f30 = 30.0;
  static const f32 = 32.0;
  static const f34 = 34.0;
  static const f36 = 36.0;
  static const f38 = 38.0;
  static const f40 = 40.0;
}
