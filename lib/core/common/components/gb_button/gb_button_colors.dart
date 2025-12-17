import 'package:flutter/material.dart';
import 'package:design_system/blocs/theme/gb_semantic_tokens.dart';
import 'gb_button_files.dart';

class GbButtonColors {
  final Color background;
  final Color foreground;
  final Color? border;

  const GbButtonColors({
    required this.background,
    required this.foreground,
    this.border,
  });
}

GbButtonColors resolveButtonColors({
  required SemanticColors colors,
  required GbButtonHierarchy hierarchy,
  required bool destructive,
  required GbButtonState state,
}) {
  final bool disabled = state == GbButtonState.disabled;
  final bool pressed = state == GbButtonState.pressed;

  //Primary
  switch (hierarchy) {
    case primary:
      if (destructive) {
        return GbButtonColors(
          background: disabled
              ? colors.backgroundDisabled
              : pressed
              ? colors.backgroundBrandRedHover
              : colors.backgroundDanger,
          foreground: disabled ? colors.textDisabled : colors.textDangerInverse,
        );
      } else {
        return GbButtonColors(
          background: disabled
              ? colors.backgroundDisabled
              : pressed
              ? colors.backgroundBrandRedPressed
              : colors.backgroundBrandRed,
          foreground: disabled ? colors.textDisabled : colors.textInverse,
        );
      }

    //Seconday-Gray
    case secondaryGray:
      if (destructive) {
        return GbButtonColors(
          background: disabled
              ? Colors.transparent
              : pressed
              ? colors.backgroundDangerSubtler
              : Colors.transparent,
          foreground: disabled ? colors.textDisabled : colors.textDanger,
          border: disabled ? colors.borderDisabled : colors.borderDanger,
        );
      } else {
        return GbButtonColors(
          background: disabled
              ? Colors.transparent
              : pressed
              ? colors.backgroundGraySubtle
              : Colors.transparent,
          foreground: disabled ? colors.textDisabled : colors.text,
          border: disabled ? colors.borderDisabled : colors.border,
        );
      }

    //Secondary-Color
    case secondaryColor:
      //Destructive logic for secondaryColor
      if (destructive) {
        return GbButtonColors(
          background: disabled
              ? Colors
                    .transparent // No background color for disabled state
              : pressed
              ? colors
                    .backgroundDangerSubtler // Background color for pressed state
              : Colors.transparent, // Background color for default state
          foreground: disabled
              ? colors
                    .textDisabled // Foreground color for disabled state
              : colors
                    .textDanger, // Foreground color for enabled states (Default and pressed states)
          border: disabled
              ? colors
                    .borderDisabled // Border color for disabled state
              : pressed
              ? colors
                    .borderDanger // Border color for pressed state
              : colors.borderDanger, // Border color for default state
        );
      } else {
        // Non-destructive logic for secondaryColor
        return GbButtonColors(
          background: disabled
              ? Colors.transparent
              : pressed
              ? colors.backgroundDangerSubtler
              : Colors.transparent,
          foreground: disabled ? colors.textDisabled : colors.textBrandRed,
          border: disabled ? colors.borderDisabled : colors.borderBrandRed,
        );
      }

    //Tertiary-Gray
    case tertiaryGray:
      if (destructive) {
        return GbButtonColors(
          background: disabled
              ? Colors.transparent
              : pressed
              ? colors.backgroundDangerSubtler
              : Colors.transparent,
          foreground: disabled ? colors.textDisabled : colors.textDanger,
          border: null,
        );
      } else {
        return GbButtonColors(
          background: disabled
              ? Colors.transparent
              : pressed
              ? colors.backgroundGraySubtle
              : Colors.transparent,
          foreground: disabled ? colors.textDisabled : colors.text,
          border: null,
        );
      }

    //Tertiary Color
    case tertiaryColor:
      if (destructive) {
        return GbButtonColors(
          background: disabled
              ? Colors.transparent
              : pressed
              ? colors.backgroundDangerSubtler
              : Colors.transparent,
          foreground: disabled ? colors.textDisabled : colors.textDangerBold,
          border: null,
        );
      } else {
        return GbButtonColors(
          background: disabled
              ? Colors.transparent
              : pressed
              ? colors.backgroundGraySubtler
              : Colors.transparent,
          foreground: disabled ? colors.textDisabled : colors.textBrandRed,
          border: null,
        );
      }

    // Link Gray
    case linkGray:
      return GbButtonColors(
        background: Colors.transparent,
        foreground: disabled
            ? colors.textDisabled
            : destructive
            ? colors.textDanger
            : colors.textBold,
      );

    // Link Color
    case linkColor:
      return GbButtonColors(
        background: Colors.transparent,
        foreground: disabled
            ? colors.textDisabled
            : destructive
            ? colors.textWarningBold
            : colors.linkPressed,
      );
  }
}
