import 'package:flutter/material.dart';
<<<<<<< HEAD
=======

>>>>>>> 56b25cea7976f76b26b9de21ba4c13a7cee7c242
import 'semantic_tokens.dart';

//final SemanticColors colors = SemanticColors.light();
ThemeData buildThemeData(SemanticColors colors, bool isDark) {
  final brightness = isDark ? Brightness.dark : Brightness.light;

  // Get ColorScheme from your SemanticColors
  final colorScheme = colors.toColorScheme(isDark: isDark);

  return ThemeData(
<<<<<<< HEAD
=======
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.colorAccent,
      brightness: brightness,
    ),
    
>>>>>>> 56b25cea7976f76b26b9de21ba4c13a7cee7c242
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: colors.backgroundColor,
    colorScheme: colorScheme,

    appBarTheme: AppBarTheme(
      backgroundColor: colors.surface,
      foregroundColor: Colors.white,
    ),
    dividerColor: colors.border,
    cardColor: colors.backgroundCard,
    iconTheme: IconThemeData(color: colors.icon),
  );
}
