import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';

import 'gb_input_types.dart';
import 'gb_input_state.dart';

/// Semantic tokens used by GbInputField.
///
/// RULES:
/// - Tokens NEVER inspect widget state
/// - Tokens ONLY depend on GbInputVisualIntent + destructive modifier
/// - Widgets must NOT branch on colors
class GbInputTokens {
  const GbInputTokens._();

  /* ------------------------------------------------------------------------
   * BORDER
   * --------------------------------------------------------------------- */

  /// Border color for NON-SEGMENTED inputs
  static Color borderColor(
    BuildContext context,
    GbInputVisualIntent intent, {
    required bool destructive,
  }) {
    final colors = SemanticColors.of(context);

    // Disabled always wins
    if (intent == GbInputVisualIntent.disabled) {
      return colors.borderDisabled;
    }

    // Destructive overrides everything else
    if (destructive) {
      return colors.borderDanger;
    }

    // Normal behavior
    switch (intent) {
      case GbInputVisualIntent.active:
        return colors.borderSelected;
      case GbInputVisualIntent.defaultState:
        return colors.borderInput;
      case GbInputVisualIntent.disabled:
        return colors.borderDisabled;
    }
  }

  static double borderWidth(GbInputVisualIntent intent) {
    return intent == GbInputVisualIntent.active ? 1.3 : 1.0;
  }

  /* ------------------------------------------------------------------------
   * SEGMENTED INPUTS
   * --------------------------------------------------------------------- */

  /// Main segment border (text field part)
  static Color segmentedMainBorderColor(
    BuildContext context,
    GbInputVisualIntent intent, {
    required bool destructive,
  }) {
    return borderColor(context, intent, destructive: destructive);
  }

  /// Secondary segment border (prefix / count / trailing button)
  static Color segmentedSecondaryBorderColor(
    BuildContext context,
    GbInputVisualIntent intent,
  ) {
    final colors = SemanticColors.of(context);

    if (intent == GbInputVisualIntent.disabled) {
      return colors.borderDisabled;
    }

    return colors.borderInput;
  }

  /* ------------------------------------------------------------------------
   * BACKGROUND
   * --------------------------------------------------------------------- */

  static Color backgroundColor(
    BuildContext context,
    GbInputVisualIntent intent,
  ) {
    final colors = SemanticColors.of(context);

    if (intent == GbInputVisualIntent.disabled) {
      return colors.backgroundDisabled;
    }

    return colors.backgroundCard;
  }

  /* ------------------------------------------------------------------------
   * TEXT
   * --------------------------------------------------------------------- */

  static Color inputTextColor(
    BuildContext context, {
    required bool isnormal,
    required bool enabled,
  }) {
    final colors = SemanticColors.of(context);

    if (!enabled) {
      return colors.textSubtle;
    }

    if (isnormal) {
      return colors.textDisabled;
    }

    return colors.text;
  }

  static Color prefixTextColor(
    BuildContext context,
    GbInputVisualIntent intent,
  ) {
    final colors = SemanticColors.of(context);

    if (intent == GbInputVisualIntent.disabled) {
      return colors.textDisabled;
    }

    return colors.text;
  }

  /* ------------------------------------------------------------------------
   * LABEL / HELPER
   * --------------------------------------------------------------------- */

  static Color labelTextColor(BuildContext context) {
    return SemanticColors.of(context).text;
  }

  static Color footerTextColor(
    BuildContext context,
    GbInputVisualIntent intent, {
    required bool destructive, // 👈 1. Add this parameter
  }) {
    final colors = SemanticColors.of(context);

    // Disabled state usually wins (gray text)
    if (intent == GbInputVisualIntent.disabled) {
      return colors.textSubtle;
    }

    // 👈 2. Check destructive state
    if (destructive) {
      return colors.textDanger; // This is your "Color/Text/text-danger"
    }

    return colors.textSubtle;
  }

  /* ------------------------------------------------------------------------
   * ICONS
   * --------------------------------------------------------------------- */

  static Color helpIconColor(BuildContext context, GbInputVisualIntent intent) {
    final colors = SemanticColors.of(context);

    if (intent == GbInputVisualIntent.disabled) {
      return colors.iconDisabled;
    }

    return colors.iconSubtle;
  }

  static Color errorIconColor(BuildContext context) {
    return SemanticColors.of(context).iconDanger;
  }

  static Color countButtonIconColor(
    BuildContext context,
    GbInputVisualIntent intent,
  ) {
    final colors = SemanticColors.of(context);

    if (intent == GbInputVisualIntent.disabled) {
      return colors.iconDisabled;
    }

    return colors.icon;
  }

  /* ------------------------------------------------------------------------
   * TYPOGRAPHY
   * --------------------------------------------------------------------- */

  static TextStyle inputTextStyle(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
      case GbInputSize.md:
        return GlobusTypography.textMdRegular;
    }
  }

  static TextStyle labelTextStyle() {
    return GlobusTypography.textSmMedium;
  }

  static TextStyle helperTextStyle() {
    return GlobusTypography.textSmRegular;
  }

  /* ------------------------------------------------------------------------
   * SVG HELPER
   * --------------------------------------------------------------------- */

  static Widget svgIcon({
    required String assetPath,
    required double size,
    required Color color,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  /* ------------------------------------------------------------------------
   * TRAILING ICON / PASSWORD / COPY
   * --------------------------------------------------------------------- */

  static Color trailingIconColor(
    BuildContext context,
    GbInputVisualIntent intent,
  ) {
    final colors = SemanticColors.of(context);

    if (intent == GbInputVisualIntent.disabled) {
      return colors.iconDisabled;
    }

    return colors.icon;
  }

  static Color trailingIconBackgroundColor(
    BuildContext context,
    GbInputVisualIntent intent,
  ) {
    final colors = SemanticColors.of(context);

    if (intent == GbInputVisualIntent.disabled) {
      return colors.backgroundDisabled;
    }

    return Colors.transparent;
  }

  /* ------------------------------------------------------------------------
   * PASSWORD ACTION (SHOW/HIDE)
   * --------------------------------------------------------------------- */

  static TextStyle passwordActionTextStyle() {
    // User Requirement: Text sm/Semibold
    return GlobusTypography.textSmSemiBold;
  }

  static Color passwordActionTextColor(
    BuildContext context,
    GbInputVisualIntent intent,
  ) {
    final colors = SemanticColors.of(context);

    if (intent == GbInputVisualIntent.disabled) {
      return colors.textDisabled;
    }
    return colors.textBold;
  }

  static Color passwordLeadingIconColor(BuildContext context, bool enabled) {
    final colors = SemanticColors.of(context);

    // Rule: "Color/Icon/icon-disabled" if disabled
    if (!enabled) {
      return colors.iconDisabled;
    }

    // Rule: "Color/Icon/icon" for ALL other states (Normal, Active, Error)
    return colors.icon;
  }

  // ─────────────────────────────────────────────
  // CLEAR BUTTON TOKENS
  // ─────────────────────────────────────────────
  static Color clearButtonColor(BuildContext context) {
    // You specified: "its color in all states is Color/Icon/icon"
    return SemanticColors.of(context).icon;
  }

  // ─────────────────────────────────────────────
  // DROPDOWN TOKENS
  // ─────────────────────────────────────────────

  static Color dropdownTextColor(BuildContext context, bool enabled) {
    final colors = SemanticColors.of(context);
    // Disabled: Color/Text/text-subtle
    // Normal:   Color/Text/text
    return enabled ? colors.text : colors.textSubtle;
  }

  static Color dropdownArrowColor(BuildContext context, bool enabled) {
    final colors = SemanticColors.of(context);
    // Disabled: Color/Icon/icon-disabled
    // Normal:   Color/Icon/icon
    return enabled ? colors.icon : colors.iconDisabled;
  }

  static TextStyle dropdownTextStyle(GbInputSize size) {
    // You specified: "Text md/Regular"
    // Assuming GlobusTypography.textMdRegular exists or mapping to it:
    return GlobusTypography.textMdRegular;
  }

  static Color prefixLeadingTextColor(
    BuildContext context,
    GbInputVisualIntent intent,
  ) {
    // Usually the same as the input text or slightly muted (e.g. gray-500)
    // Adjust 'colors.text' to 'colors.textSecondary' if you want it lighter.
    final colors = SemanticColors.of(context);
    return colors.text;
  }

  // ───────── CHIP TOKENS ─────────

  static Color chipBackgroundColor(
    BuildContext context, {
    required bool enabled,
  }) {
    final colors = SemanticColors.of(context);
    // Note: The disabled state affects the FIELD background, but usually chips
    // keep their own card color unless specified otherwise.
    // Based on your note: "Background Color: Color/Background/background-card"
    return colors.backgroundCard;
  }

  static Color chipBorderColor(BuildContext context) {
    final colors = SemanticColors.of(context);
    return colors.borderSubtle;
  }

  static TextStyle chipTextStyle(GbInputSize size) {
    // Usually slightly smaller than input text, or the same.
    // Assuming same size as input for now (14px/16px).
    return inputTextStyle(size).copyWith(fontWeight: FontWeight.w400);
  }

  static Color chipTextColor(BuildContext context, {required bool enabled}) {
    final colors = SemanticColors.of(context);
    return enabled ? colors.text : colors.textDisabled;
  }
}
