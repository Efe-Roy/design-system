import 'package:flutter/material.dart';
import 'package:design_system/core/common/constants/gb_semantic_tokens.dart'; // ⚠️ Verify path
import 'gb_badge_types.dart';

/// Configuration object for badge colors
class GbBadgeColorConfig {
  final Color background;
  final Color? border;
  final Color text;
  final Color icon; // Used for Dot or Generic Icons

  const GbBadgeColorConfig({
    required this.background,
    this.border,
    required this.text,
    required this.icon,
  });
}

class GbBadgeTokens {
  const GbBadgeTokens._();

  static GbBadgeColorConfig resolve({
    required BuildContext context,
    required GbBadgeType type,
    required GbBadgeColor color,
    required GbBadgeIcon icon,
  }) {
    final colors = SemanticColors.of(context);

    // 1️⃣ Resolve Intent-based Palettes
    // We determine the raw colors first, then apply component rules
    Color bgIntent;
    Color textIntent;
    Color borderIntent;
    Color iconIntent;

    switch (color) {
      case GbBadgeColor.gray:
        bgIntent = colors
            .backgroundGraySubtler; // or Subtlest depending on specific token map
        textIntent = colors.text;
        borderIntent = colors.borderSubtler;
        iconIntent = colors.icon;
        break;
      case GbBadgeColor.primary:
        bgIntent = colors
            .backgroundInformationSubtlest; // "Brand" usually maps to Info or specific Brand token
        textIntent = colors.textBrandDarkBlue;
        borderIntent = colors.borderInformationSubtler;
        iconIntent = colors.iconDarkBlue;
        break;
      case GbBadgeColor.error:
        bgIntent = colors.backgroundDangerSubtlest;
        textIntent = colors.textDanger;
        borderIntent = colors.borderDangerSubtler;
        iconIntent = colors.iconDanger;
        break;
      case GbBadgeColor.warning:
        bgIntent = colors.backgroundWarningSubtlest;
        textIntent = colors.textWarning;
        borderIntent = colors.borderWarningSubtler;
        iconIntent = colors.iconWarning;
        break;
      case GbBadgeColor.success:
        bgIntent = colors.backgroundSuccessSubtlest;
        textIntent = colors.textSuccess;
        borderIntent = colors.borderSuccessSubtler;
        iconIntent = colors.iconSuccess;
        break;
      case GbBadgeColor.pink:
        bgIntent = colors.backgroundPinkSubtlest;
        textIntent = colors.textPink;
        borderIntent = colors.borderPinkSubtler;
        iconIntent = colors.iconPink;
        break;
      case GbBadgeColor.purple:
        bgIntent = colors.backgroundPurpleSubtlest;
        textIntent = colors.textPurple;
        borderIntent = colors.borderPurpleSubtler;
        iconIntent = colors.iconPurple;
        break;
      case GbBadgeColor.discovery:
        bgIntent = colors.backgroundDiscoverySubtlest;
        textIntent = colors.textDiscovery;
        borderIntent = colors.borderDiscoverySubtler;
        iconIntent = colors.iconDiscovery;
        break;
      case GbBadgeColor.information:
        bgIntent = colors.backgroundInformationSubtlest;
        textIntent = colors.textInformation;
        borderIntent = colors.borderInformationSubtler;
        iconIntent = colors.iconInformation;
        break;
    }

    // 2️⃣ Apply Logic Rules (Type Overrides)

    // 📜 Rule 1: Modern Badge
    if (type == GbBadgeType.badgeModern) {
      if (icon == GbBadgeIcon.dot) {
        // Dot: Transparent BG, Gray Text, Dynamic Dot Color
        return GbBadgeColorConfig(
          background: Colors.transparent,
          border: colors.borderSubtler,
          text: colors.text,
          icon: iconIntent, // Dynamic Dot
        );
      } else {
        // Not Dot: Transparent BG, Gray Text, Gray Icon
        return GbBadgeColorConfig(
          background: Colors.transparent,
          border: colors.borderSubtler,
          text: colors.text,
          icon: colors.icon, // Fixed Gray Icon
        );
      }
    }

    // 📜 Rule 2: Pill Outline
    if (type == GbBadgeType.pillOutline) {
      return GbBadgeColorConfig(
        background: Colors.transparent,
        border: textIntent, // Rule: Border matches strong text color
        text: textIntent,
        icon: textIntent, // Icons match text in outline
      );
    }

    // 📜 Rule 3: Filled (Pill Color & Badge Color)
    return GbBadgeColorConfig(
      background: bgIntent,
      border: borderIntent,
      text: textIntent,
      icon: textIntent,
    );
  }
}
