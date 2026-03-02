import 'package:design_system/core/common/constants/gb_radius.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';
import 'package:flutter/material.dart';
import 'gb_tab_types.dart';

class GbTabGeometry {
  // ────────────────────────────────────────────
  // 📏 1. ITEM MEASUREMENTS
  // ────────────────────────────────────────────
  static double height(GbTabSize size) {
    switch (size) {
      case GbTabSize.sm:
        return 38.0;
      case GbTabSize.md:
        return 44.0;
    }
  }

  static EdgeInsets padding(GbTabSize size) {
    switch (size) {
      case GbTabSize.sm:
        return const EdgeInsets.symmetric(horizontal: 16.0);
      case GbTabSize.md:
        return const EdgeInsets.symmetric(horizontal: 20.0);
    }
  }

  static const double gapTextToBadge = 8.0;
  static const double badgeHeight = 24.0;
  static const double listGap = 8.0;
  static const double activeBorderWidth = 2.0;

  // ────────────────────────────────────────────
  // 📏 2. ITEM BORDER RADIUS
  // ────────────────────────────────────────────
  static BorderRadius borderRadius(GbTabType type) {
    switch (type) {
      case GbTabType.buttonPrimary:
      case GbTabType.buttonGray:
      case GbTabType.buttonWhite:
        return BorderRadius.circular(GlobusRadius.xs);

      case GbTabType.buttonWhiteBorder:
        // Needs to fit inside the 8px container padding
        return BorderRadius.circular(GlobusRadius.sm);

      case GbTabType.roundedButtonWhiteBorder:
        return BorderRadius.circular(GlobusRadius.full); // Full Pill

      case GbTabType.underline:
      case GbTabType.underlineFilled:
        return BorderRadius.zero;
    }
  }

  // ────────────────────────────────────────────
  // 📏 3. CONTAINER METRICS (New!)
  // ────────────────────────────────────────────

  // Padding AROUND the group of tabs
  static EdgeInsets containerPadding(GbTabType type) {
    if (type == GbTabType.buttonWhiteBorder ||
        type == GbTabType.roundedButtonWhiteBorder) {
      return const EdgeInsets.all(4.0);
    }
    return EdgeInsets.zero;
  }

  // Radius of the CONTAINER itself
  static BorderRadius containerRadius(GbTabType type) {
    if (type == GbTabType.buttonWhiteBorder) {
      return BorderRadius.circular(GlobusRadius.sm);
    }
    if (type == GbTabType.roundedButtonWhiteBorder) {
      return BorderRadius.circular(GlobusRadius.full);
    }
    return BorderRadius.zero;
  }

  // ────────────────────────────────────────────
  // 🔤 4. TYPOGRAPHY
  // ────────────────────────────────────────────
  static TextStyle textStyle(GbTabSize size, bool isActive) {
    if (size == GbTabSize.md) {
      return isActive
          ? GlobusTypography.textMdSemiBold
          : GlobusTypography.textMdMedium;
    } else {
      return isActive
          ? GlobusTypography.textSmSemiBold
          : GlobusTypography.textSmMedium;
    }
  }
}
