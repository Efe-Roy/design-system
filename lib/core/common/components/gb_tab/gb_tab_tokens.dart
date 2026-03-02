import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';
import 'package:flutter/material.dart';
import 'gb_tab_types.dart';
import 'package:design_system/core/common/components/gb_badge/gb_badge_types.dart';

// ─── 1. ITEM TOKENS (Existing) ───
class GbTabColors {
  final Color background;
  final Color text;
  final Color? border;
  final GbBadgeColor badgeColor;

  const GbTabColors({
    required this.background,
    required this.text,
    this.border,
    required this.badgeColor,
  });
}

// ─── 2. CONTAINER TOKENS ───
class GbTabContainerTokens {
  final Color backgroundColor;
  final Color? borderColor;
  final Color? trackLineColor; // The grey line under "Underline" tabs

  const GbTabContainerTokens({
    required this.backgroundColor,
    this.borderColor,
    this.trackLineColor,
  });

  static GbTabContainerTokens resolve({
    required GbTabType type,
    required SemanticColors colors,
  }) {
    switch (type) {
      // UNDERLINE: Needs the track line
      case GbTabType.underline:
      case GbTabType.underlineFilled:
        return GbTabContainerTokens(
          backgroundColor: Colors.transparent,
          borderColor: null,
          trackLineColor: colors.borderSubtler,
        );

      // BUTTON WHITE BORDER: Needs the Grey Box
      case GbTabType.buttonWhiteBorder:
      case GbTabType.roundedButtonWhiteBorder:
        return GbTabContainerTokens(
          backgroundColor: colors.backgroundGraySubtler,
          borderColor: colors.borderSubtler,
          trackLineColor: null,
        );

      default:
        return GbTabContainerTokens(
          backgroundColor: Colors.transparent,
          borderColor: null,
          trackLineColor: null,
        );
    }
  }
}

class GbTabTokens {
  static GbTabColors resolve({
    required GbTabType type,
    required bool current,
    required SemanticColors colors,
  }) {
    GbBadgeColor getBadgeColor() {
      if (!current) return GbBadgeColor.gray;
      if (type == GbTabType.buttonWhite ||
          type == GbTabType.buttonGray ||
          type == GbTabType.buttonWhiteBorder ||
          type == GbTabType.roundedButtonWhiteBorder) {
        return GbBadgeColor.gray;
      }
      return GbBadgeColor.information;
    }

    // 1. BUTTON WHITE FAMILY
    if (type == GbTabType.buttonWhite ||
        type == GbTabType.buttonWhiteBorder ||
        type == GbTabType.roundedButtonWhiteBorder) {
      if (current) {
        return GbTabColors(
          background: colors.backgroundCard,
          text: colors.textBold,
          border: null,
          badgeColor: getBadgeColor(),
        );
      } else {
        return GbTabColors(
          background: Colors.transparent,
          text: colors.text,
          border: null,
          badgeColor: getBadgeColor(),
        );
      }
    }

    // 2. PRIMARY
    if (type == GbTabType.buttonPrimary) {
      if (current) {
        return GbTabColors(
          background: colors.backgroundInformationSubtlest,
          text: colors.textSelected,
          border: null,
          badgeColor: getBadgeColor(),
        );
      } else {
        return GbTabColors(
          background: Colors.transparent,
          text: colors.text,
          border: null,
          badgeColor: getBadgeColor(),
        );
      }
    }

    // 3. GRAY
    if (type == GbTabType.buttonGray) {
      if (current) {
        return GbTabColors(
          background: colors.backgroundGraySubtlest,
          text: colors.textBold,
          border: null,
          badgeColor: getBadgeColor(),
        );
      } else {
        return GbTabColors(
          background: Colors.transparent,
          text: colors.text,
          border: null,
          badgeColor: getBadgeColor(),
        );
      }
    }

    // 4. UNDERLINE FAMILY
    if (type == GbTabType.underline || type == GbTabType.underlineFilled) {
      if (current) {
        return GbTabColors(
          background: (type == GbTabType.underlineFilled)
              ? colors.backgroundInformationSubtlest
              : Colors.transparent,
          text: colors.textSelected,
          border: colors.borderSelected, // The active blue line
          badgeColor: getBadgeColor(),
        );
      } else {
        return GbTabColors(
          background: Colors.transparent,
          text: colors.text,
          border: null,
          badgeColor: getBadgeColor(),
        );
      }
    }

    return GbTabColors(
      background: Colors.transparent,
      text: colors.text,
      badgeColor: GbBadgeColor.gray,
    );
  }
}
