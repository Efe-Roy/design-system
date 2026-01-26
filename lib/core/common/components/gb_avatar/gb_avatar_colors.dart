import 'package:flutter/material.dart';
import 'package:design_system/blocs/theme/gb_semantic_tokens.dart';
import 'gb_avatar_types.dart';

// Holds all color-related configuration for an avatar
class GbAvatarColors {
  // Background color of the avatar circle.
  // Null when avatar uses an image.
  final Color? background;

  // Foreground color (initials text or normal icon).
  final Color? foreground;

  // Optional contrast border color.
  final Color? border;

  // Background color for online / offline status dot.
  final Color statusBackground;

  // Border color for status dot.
  final Color statusBorder;

  // Color for verified badge icon.
  final Color verifiedBadge;

  // Border color for verified badge icon.
  final Color verifiedBadgeBorder;

  // Border Color for company badge icon
  final Color companyBadgeBorder;

  const GbAvatarColors({
    required this.background,
    required this.foreground,
    required this.border,
    required this.statusBackground,
    required this.statusBorder,
    required this.verifiedBadge,
    required this.verifiedBadgeBorder,
    required this.companyBadgeBorder,
  });
}

/// Resolves avatar colors based on design tokens and Figma behavior.
GbAvatarColors resolveAvatarColors({
  required SemanticColors colors,
  required GbAvatarColor variant,
  required GbAvatarState state,
  required bool contrastBorder,
}) {
  final bool isPressed = state == GbAvatarState.pressed;

  Color background;
  Color foreground;

  switch (variant) {
    case GbAvatarColor.gray:
      background = isPressed
          ? colors.backgroundGraySubtlest
          : colors.backgroundGraySubtler;
      foreground = colors.text;
      break;

    case GbAvatarColor.blue:
      background = isPressed
          ? colors.backgroundInformationSubtlest
          : colors.backgroundInformationSubtler;
      foreground = colors.textInformation;
      break;

    case GbAvatarColor.cyan:
      background = isPressed
          ? colors.backgroundDiscoverySubtlest
          : colors.backgroundDiscoverySubtler;
      foreground = colors.textDiscovery;
      break;

    case GbAvatarColor.pink:
      background = isPressed
          ? colors.backgroundPinkSubtlest
          : colors.backgroundPinkSubtler;
      foreground = colors.textPink;
      break;

    case GbAvatarColor.purple:
      background = isPressed
          ? colors.backgroundPurpleSubtlest
          : colors.backgroundPurpleSubtler;
      foreground = colors.textPurple;
      break;

    case GbAvatarColor.green:
      background = isPressed
          ? colors.backgroundSuccessSubtlest
          : colors.backgroundSuccessSubtler;
      foreground = colors.textSuccess;
      break;

    case GbAvatarColor.yellow:
      background = isPressed
          ? colors.backgroundWarningSubtlest
          : colors.backgroundWarningSubtler;
      foreground = colors.textWarning;
      break;
  }

  return GbAvatarColors(
    background: background,
    foreground: foreground,
    border: contrastBorder ? colors.borderInverse : null,
    statusBackground: colors.iconSuccess,
    statusBorder: colors.borderInverse,
    verifiedBadge: colors.iconDiscovery,
    verifiedBadgeBorder: colors.borderInverse,
    companyBadgeBorder: colors.borderInverse,
  );
}
