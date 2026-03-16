import 'package:flutter/material.dart';
import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';
import 'gb_input_dropdown_types.dart';

class GbInputDropdownTokens {
  const GbInputDropdownTokens._();

  // ===========================================================================
  // TRIGGER BUTTON TOKENS
  // ===========================================================================
  static Color backgroundColor(
    BuildContext context,
    GbInputDropdownState state,
  ) {
    final colors = SemanticColors.of(context);
    return state == GbInputDropdownState.disabled
        ? colors.backgroundDisabled
        : colors.backgroundCard;
  }

  static Color borderColor(BuildContext context, GbInputDropdownState state) {
    final colors = SemanticColors.of(context);
    if (state == GbInputDropdownState.disabled ||
        state == GbInputDropdownState.filled ||
        state == GbInputDropdownState.normal) {
      return colors.borderInput;
    }
    return colors.borderSelected;
  }

  static double borderWidth(GbInputDropdownState state) =>
      state == GbInputDropdownState.focused ? 1.5 : 1.0;

  static TextStyle labelTextStyle(BuildContext context) => GlobusTypography
      .textSmMedium
      .copyWith(color: SemanticColors.of(context).text);
  static TextStyle hintTextStyle(BuildContext context) => GlobusTypography
      .textSmRegular
      .copyWith(color: SemanticColors.of(context).textSubtle);

  static TextStyle inputTextStyle(
    BuildContext context,
    GbInputDropdownSize size,
    bool isDisabled,
  ) {
    final style = size == GbInputDropdownSize.sm
        ? GlobusTypography.textSmRegular
        : GlobusTypography.textMdRegular;
    return style.copyWith(
      color: isDisabled
          ? SemanticColors.of(context).textDisabled
          : SemanticColors.of(context).text,
    );
  }

  static TextStyle placeholderTextStyle(
    BuildContext context,
    GbInputDropdownSize size,
  ) {
    final style = size == GbInputDropdownSize.sm
        ? GlobusTypography.textSmRegular
        : GlobusTypography.textMdRegular;
    return style.copyWith(color: SemanticColors.of(context).textDisabled);
  }

  static Color iconColor(BuildContext context, GbInputDropdownState state) =>
      SemanticColors.of(context).iconSubtle;

  // ===========================================================================
  //  MODAL OVERLAY TOKENS
  // ===========================================================================
  static Color modalContentBackgroundColor(BuildContext context) =>
      SemanticColors.of(context).surface;
  static Color dragHandleColor(BuildContext context) =>
      SemanticColors.of(context).iconDisabled;
  static TextStyle modalTitleTextStyle(BuildContext context) => GlobusTypography
      .displayXsSemiBold
      .copyWith(color: SemanticColors.of(context).textBold);

  // Dynamic Overlay states
  // static Color modalBarrierColorBefore(BuildContext context) =>
  //     SemanticColors.of(context).blanketSubtle;
  static Color modalBarrierColorBefore(BuildContext context) =>
      SemanticColors.of(context).blanket;
  static Color modalBarrierColorAfter(BuildContext context) =>
      SemanticColors.of(context).blanket;
  // ===========================================================================
  //  MENU ITEM TOKENS (Strict State Matrix)
  // ===========================================================================
  static Color itemDividerColor(BuildContext context) =>
      SemanticColors.of(context).borderSubtler;
  static Color checkmarkColor(BuildContext context) =>
      SemanticColors.of(context).iconSelected;

  // Layer 3: Dynamic Background Color
  static Color itemBackgroundColor(
    BuildContext context, {
    required bool isSelected,
    required bool isPressed,
    required bool isEnabled,
  }) {
    final colors = SemanticColors.of(context);
    if (!isEnabled) return Colors.transparent;
    if (isPressed) return colors.backgroundGraySubtle;
    if (isSelected) return colors.backgroundInformationSubtler;
    return Colors.transparent;
  }

  // Layer 3: Dynamic Text Color
  static TextStyle itemTitleTextStyle(
    BuildContext context, {
    required bool isEnabled,
  }) {
    return GlobusTypography.textMdMedium.copyWith(
      color: isEnabled
          ? SemanticColors.of(context).text
          : SemanticColors.of(context).textDisabled,
    );
  }

  static TextStyle itemSupportingTextStyle(
    BuildContext context, {
    required bool isEnabled,
  }) {
    return GlobusTypography.textSmRegular.copyWith(
      color: isEnabled
          ? SemanticColors.of(context).text
          : SemanticColors.of(context).textDisabled,
    );
  }

  // Layer 3: Dynamic Leading Icon Color
  static Color itemLeadingIconColor(
    BuildContext context, {
    required bool isEnabled,
  }) {
    return isEnabled
        ? SemanticColors.of(context).icon
        : SemanticColors.of(context).iconDisabled;
  }
}
