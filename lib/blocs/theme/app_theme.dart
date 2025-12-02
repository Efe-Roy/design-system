import 'package:flutter/material.dart';

import 'app_text_theme.dart';
import 'semantic_tokens.dart';

ThemeData buildThemeData(SemanticColors colors, bool isDark) {
  final brightness = isDark ? Brightness.dark : Brightness.light;

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.colorAccent,
      brightness: brightness,
    ),

    textTheme: AppTextTheme.buildTextTheme(
      colors,
    ), // ✅ Use our centralized text theme

    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: colors.backgroundColor,

    appBarTheme: AppBarTheme(
      backgroundColor: colors.colorAccent,
      foregroundColor: Colors.white,
    ),
    dividerColor: colors.border,
    cardColor: colors.backgroundCard,
    iconTheme: IconThemeData(color: colors.icon),
  );
}
