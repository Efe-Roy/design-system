import 'package:flutter/material.dart';
import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';
import 'gb_token_field_types.dart';

class GbTokenFieldTokens {
  const GbTokenFieldTokens._();

  // 🎨 BORDERS
  static Color borderColor(
    BuildContext context, {
    required bool isActive,
    required bool isDisabled,
  }) {
    final colors = SemanticColors.of(context);
    if (isDisabled) return colors.borderDisabled;
    if (isActive) return colors.borderSelected;
    return colors.borderInput; // Placeholder and Filled share this
  }

  // 🎨 BACKGROUNDS
  static Color? backgroundColor(
    BuildContext context, {
    required bool isDisabled,
  }) {
    final colors = SemanticColors.of(context);
    if (isDisabled) return colors.backgroundGraySubtlest;
    return colors
        .backgroundCard; // Transparent for placeholder, filled, and active
  }

  // 🔤 TYPOGRAPHY: Filled & Active (The typed numbers)
  static TextStyle activeTextStyle(
    BuildContext context,
    GbTokenFieldSize size, {
    required bool isDisabled,
  }) {
    final colors = SemanticColors.of(context);
    final baseStyle = size == GbTokenFieldSize.sm
        ? GlobusTypography.textXsMedium
        : GlobusTypography.textMdMedium;

    return baseStyle.copyWith(
      color: isDisabled ? colors.textDisabled : colors.text,
    );
  }

  // 🔤 TYPOGRAPHY: Placeholder (The empty dash `-` in compact)
  static TextStyle placeholderTextStyle(BuildContext context) {
    return GlobusTypography.textXsMedium.copyWith(
      color: SemanticColors.of(context).textDisabled,
    );
  }

  // 🔤 TYPOGRAPHY: The Divider (`-` between groups)
  static TextStyle dividerTextStyle(BuildContext context) {
    return GlobusTypography.textSmBold.copyWith(
      color: SemanticColors.of(context).borderInput,
    );
  }

  // 🏷️ LABELS & HINTS
  static TextStyle labelTextStyle(BuildContext context) {
    return GlobusTypography.textSmMedium.copyWith(
      color: SemanticColors.of(context).text,
    );
  }

  static TextStyle hintTextStyle(BuildContext context) {
    return GlobusTypography.textSmRegular.copyWith(
      color: SemanticColors.of(context).textSubtle,
    );
  }
}
