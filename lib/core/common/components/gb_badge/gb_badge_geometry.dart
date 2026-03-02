import 'package:flutter/material.dart';
import 'gb_badge_types.dart';
import 'package:design_system/core/common/constants/gb_spacing.dart';
import 'package:design_system/core/common/constants/gb_radius.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';

class GbBadgeGeometry {
  const GbBadgeGeometry._();

  // ─────────────────────────────────────────────
  // 📏 HEIGHTS
  // ─────────────────────────────────────────────
  // These are component-specific fixed heights from the Figma spec.
  static double height(GbBadgeSize size) {
    switch (size) {
      case GbBadgeSize.sm:
        return 22.0;
      case GbBadgeSize.md:
        return 24.0;
      case GbBadgeSize.lg:
        return 28.0;
    }
  }

  // ─────────────────────────────────────────────
  // ↔️ PADDING (Left/Right)
  // ─────────────────────────────────────────────
  static EdgeInsets padding(GbBadgeSize size) {
    switch (size) {
      case GbBadgeSize.sm:
      case GbBadgeSize.md:
        // sm/md use Spacing2 (8px)
        return const EdgeInsets.symmetric(horizontal: GlobusSpacing.spacing2);
      case GbBadgeSize.lg:
        // lg uses Spacing3 (12px)
        return const EdgeInsets.symmetric(horizontal: GlobusSpacing.spacing3);
    }
  }

  // ─────────────────────────────────────────────
  // 📐 GAPS (Between Elements)
  // ─────────────────────────────────────────────

  /// Gap for: Dot, Country, Avatar -> Text (6px)
  /// Derived: spacing1 (4px) + spacingHalf (2px)
  static const double gapStandard =
      GlobusSpacing.spacing1 + GlobusSpacing.spacingHalf;

  /// Gap for: IconLeading -> Text (4px)
  static const double gapIconLeading = GlobusSpacing.spacing1;

  /// Gap for: Text -> IconTrailing (4px)
  static const double gapIconTrailing = GlobusSpacing.spacing1;

  /// Gap for: Text -> xClose (2px)
  static const double gapXClose = GlobusSpacing.spacingHalf;

  // ─────────────────────────────────────────────
  // 🖼️ ICON & AVATAR SIZES
  // ─────────────────────────────────────────────

  /// Size for Country Flag (Fixed 18px all sizes)
  static const double countryIconSize = 18.0;

  /// Size for Leading, Trailing, and Only Icons (Fixed 12px all sizes)
  static const double genericIconSize = 12.0;

  /// Size for Avatar (xxs)
  static const double avatarSize = 18.0;

  // ─────────────────────────────────────────────
  // 🔘 BORDER RADIUS
  // ─────────────────────────────────────────────

  static BorderRadius borderRadius(GbBadgeType type) {
    switch (type) {
      case GbBadgeType.pillColor:
      case GbBadgeType.pillOutline:
        // 999px
        return BorderRadius.circular(GlobusRadius.full);
      case GbBadgeType.badgeColor:
      case GbBadgeType.badgeModern:
        // 4px
        return BorderRadius.circular(GlobusRadius.xs);
    }
  }

  // ─────────────────────────────────────────────
  // 🔠 TEXT STYLES (From GlobusTypography)
  // ─────────────────────────────────────────────
  // Mapped strictly from the Figma Spec Table
  static TextStyle textStyle(GbBadgeSize size) {
    switch (size) {
      case GbBadgeSize.sm:
        // Spec: "Text xs/Medium"
        return GlobusTypography.textXsMedium;
      case GbBadgeSize.md:
      case GbBadgeSize.lg:
        // Spec: "Text sm/Medium" (For both Medium and Large)
        return GlobusTypography.textSmMedium;
    }
  }
}
