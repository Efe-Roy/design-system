import 'package:flutter/material.dart';
import '../../core/common/constants/gb_semantic_tokens.dart';
import '../../core/common/constants/gb_text_style.dart';

//final SemanticColors colors = SemanticColors.light();
ThemeData buildThemeData(SemanticColors colors, bool isDark) {
  final brightness = isDark ? Brightness.dark : Brightness.light;

  // Get ColorScheme from your SemanticColors
  final colorScheme = colors.toColorScheme(isDark: isDark);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: fontFamilySora,
    scaffoldBackgroundColor: colors.backgroundColor,
    colorScheme: colorScheme,
    extensions: <ThemeExtension<dynamic>>[colors],

    appBarTheme: AppBarTheme(
      backgroundColor: colors.surface,
      foregroundColor: Colors.white,
    ),
    dividerColor: colors.border,
    cardColor: colors.backgroundCard,
    iconTheme: IconThemeData(color: colors.icon),
  );
}
