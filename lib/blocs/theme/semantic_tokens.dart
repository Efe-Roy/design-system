// core/theme/semantic_tokens.dart
import 'package:flutter/material.dart';
import 'color_tokens.dart';

class SemanticColors {
  final Color colorBgSurface;
  final Color colorBgElevated;
  final Color colorTextPrimary;
  final Color colorTextSecondary;
  final Color colorTextOnAccent;
  final Color colorBorder;
  final Color colorAccent;

  const SemanticColors({
    required this.colorBgSurface,
    required this.colorBgElevated,
    required this.colorTextPrimary,
    required this.colorTextSecondary,
    required this.colorTextOnAccent,
    required this.colorBorder,
    required this.colorAccent,
  });

  factory SemanticColors.light() {
    return const SemanticColors(
      colorBgSurface: Colors.white,
      colorBgElevated: ColorTokens.gray50,
      colorTextPrimary: ColorTokens.gray900,
      colorTextSecondary: ColorTokens.gray600,
      colorTextOnAccent: Colors.white,
      colorBorder: ColorTokens.gray200,
      colorAccent: ColorTokens.primary,
    );
  }

  factory SemanticColors.dark() {
    return const SemanticColors(
      colorBgSurface: ColorTokens.gray900,
      colorBgElevated: ColorTokens.gray800,
      colorTextPrimary: Colors.white,
      colorTextSecondary: ColorTokens.gray300,
      colorTextOnAccent: Colors.black,
      colorBorder: ColorTokens.gray700,
      colorAccent: ColorTokens.primary,
    );
  }
}
