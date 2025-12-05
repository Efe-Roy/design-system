import 'package:flutter/material.dart';

import 'semantic_tokens.dart';

ThemeData buildThemeData(SemanticColors colors, bool isDark) {
  final brightness = isDark ? Brightness.dark : Brightness.light;

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.colorAccent,
      brightness: brightness,
    ),
    
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
