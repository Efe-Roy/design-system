import 'package:flutter/material.dart';
import 'package:design_system/core/common/constants/gb_radius.dart';
import 'package:design_system/core/common/constants/gb_spacing.dart';
import 'gb_token_field_types.dart';

class GbTokenFieldGeometry {
  const GbTokenFieldGeometry._();

  // COMPRESSED BOX SIZES (Individual Boxes)
  static double boxSize(GbTokenFieldSize size) {
    switch (size) {
      case GbTokenFieldSize.sm:
        return 44.0;
      case GbTokenFieldSize.md:
        return 48.0;
      case GbTokenFieldSize.lg:
        return 56.0;
    }
  }

  static EdgeInsets boxPadding(GbTokenFieldSize size) {
    switch (size) {
      case GbTokenFieldSize.sm:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0);
      case GbTokenFieldSize.md:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0);
      case GbTokenFieldSize.lg:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0);
    }
  }

  //  COMPACT INNER BOX SIZES (Inside the Pill)
  static const double compactBoxMinWidth = 32.0;
  static EdgeInsets compactBoxPadding = const EdgeInsets.symmetric(
    horizontal: 8.0,
    vertical: 2.0,
  );

  //  THE SHADOW (From Figma: X:0, Y:1, Blur:2, Spread:0, Color: #101828 at 5%)
  static List<BoxShadow> boxEdgeShadow = [
    BoxShadow(
      color: const Color(0xFF101828).withValues(alpha: 0.05),
      offset: const Offset(0, 1),
      blurRadius: 2.0,
      spreadRadius: 0.0,
    ),
  ];

  //  BORDER RADIUS & WIDTH
  static const double borderRadius = 8.0;
  static const double motherRadius = GlobusRadius.sm;
  static const double borderWidth = 1.0;

  // ↔ GAPS & DIVIDER SPACING
  static double gap(GbTokenFieldSize size) =>
      size == GbTokenFieldSize.sm ? 8.0 : 12.0;

  static double dividerSpacing(GbTokenFieldSize size) =>
      size == GbTokenFieldSize.sm ? 8.0 : 12.0;

  //  LABEL & HINT SPACING
  static const double labelToFieldSpacing = GlobusSpacing.spacing2;
  static const double fieldToHintSpacing = GlobusSpacing.spacing2;
}
