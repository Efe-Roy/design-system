import 'package:flutter/material.dart';

import 'semantic_tokens.dart';

class AppTextTheme {
  /// Builds a TextTheme based on the provided [colors].
  static TextTheme buildTextTheme(SemanticColors colors) {
    return TextTheme(
      bodyLarge: TextStyle(
        color: colors.colorTextPrimary,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: colors.colorTextSecondary,
        fontSize: 14,
      ),
      titleLarge: TextStyle(
        color: colors.colorTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      labelLarge: TextStyle(
        color: colors.colorAccent,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      // Add more text styles as needed:
      headlineLarge: TextStyle(
        color: colors.colorTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headlineMedium: TextStyle(
        color: colors.colorTextPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      // caption, subtitle, button, etc.
    );
  }
}
