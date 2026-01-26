import 'package:flutter/material.dart';

import 'gb_input_types.dart';
import 'package:design_system/blocs/theme/gb_spacing.dart';

/// Defines all size, spacing, and layout-related constants for GbInputField.
///
/// This file is purely about geometry:
/// - sizes
/// - spacing
/// - segment layout
/// - border radius rules
///
/// No colors. No state logic.
///
enum GbInputSegment { primary, secondary }

class GbInputGeometry {
  const GbInputGeometry._();

  /* ------------------------------------------------------------------------
   * Segmentation
   * --------------------------------------------------------------------- */

  /// Visual segments inside a single input container.
  ///
  /// - primary: the main value / text area
  /// - secondary: prefix, copy button, +/- buttons, etc.

  /// Whether an input kind renders multiple visual segments.
  ///
  /// IMPORTANT:
  /// This refers only to **visually segmented** inputs
  /// (i.e. internal divider + separate bordered areas).
  static bool isSegmented(GbInputType kind) {
    switch (kind) {
      case GbInputType.leadingText:
      case GbInputType.count:
        return true;

      default:
        return false;
    }
  }

  /// Border radius for a given visual segment.
  ///
  /// Only the outermost segments receive rounded corners.
  static BorderRadius segmentBorderRadius({
    required GbInputSize size,
    required bool isFirst,
    required bool isLast,
  }) {
    final r = Radius.circular(borderRadius(size));

    return BorderRadius.only(
      topLeft: isFirst ? r : Radius.zero,
      bottomLeft: isFirst ? r : Radius.zero,
      topRight: isLast ? r : Radius.zero,
      bottomRight: isLast ? r : Radius.zero,
    );
  }

  /// Standard divider width between segments.
  static const double segmentDividerWidth = 1.0;

  /* ------------------------------------------------------------------------
   * Container dimensions
   * --------------------------------------------------------------------- */

  static double height(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 40.0;
      case GbInputSize.md:
        return 48.0;
    }
  }

  static double paddingLeft(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 12.0;
      case GbInputSize.md:
        return 12.0;
    }
  }

  static double paddingRight(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 12.0;
      case GbInputSize.md:
        return 14.0;
    }
  }

  static double borderRadius(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
      case GbInputSize.md:
        return 8.0;
    }
  }

  /* ------------------------------------------------------------------------
   * Vertical spacing
   * --------------------------------------------------------------------- */

  static const double labelToFieldSpacing = GlobusSpacing.spacing1;
  static const double fieldToFooterSpacing = 8.0;

  /* ------------------------------------------------------------------------
   * Icons
   * --------------------------------------------------------------------- */

  static const double helpIconSize = 16.0;
  static const double errorIconSize = 16.0;

  static double leadingIconSize(GbInputType kind) {
    switch (kind) {
      case GbInputType.iconLeading:
      case GbInputType.password:
        return 20.0;

      case GbInputType.leadingDropdown:
        return 24.0;

      default:
        return 0.0;
    }
  }

  static const double currencyIconWidth = 11.0;
  static const double currencyIconHeight = 12.0;

  /* ------------------------------------------------------------------------
   * Horizontal spacing
   * --------------------------------------------------------------------- */

  static const double leadingToPrefixSpacing = 4.0;
  static const double leadingToContentSpacing = 8.0;

  static double prefixToContentSpacing(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 10.0;
      case GbInputSize.md:
        return 12.0;
    }
  }

  static const double contentToInfoIconSpacing = 8.0;

  static double infoIconToTrailingSpacing(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 12.0;
      case GbInputSize.md:
        return 14.0;
    }
  }

  static const double trailingToTrailingSpacing = 6.0;
  static const double chipToChipSpacing = 6.0;

  /* ------------------------------------------------------------------------
   * LEADING TEXT (e.g. https://, www.)
   * --------------------------------------------------------------------- */

  /// Minimum width for leading text segment
  /// Prevents collapse when text is short
  static const double leadingTextMinWidth = 51;

  /* ------------------------------------------------------------------------
   * Count input
   * --------------------------------------------------------------------- */

  static const double countButtonWidth = 40.0;

  // ─────────────────────────────────────────────
  // Trailing Icon Button (Input)
  // ─────────────────────────────────────────────

  /// Fixed container size for trailing icon button
  static double trailingIconContainerSize(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 36;
      case GbInputSize.md:
        return 44;
    }
  }

  /// Fixed icon size inside trailing icon container
  static const double trailingIconSize = 16;

  /// Spacing between help/error icon and trailing icon
  static double trailingIconSpacing(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 24;
      case GbInputSize.md:
        return 24;
    }
  }

  // ─────────────────────────────────────────────
  // PASSWORD TOGGLE
  // ─────────────────────────────────────────────

  static double passwordToggleWidth(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 72;
      case GbInputSize.md:
        return 80;
    }
  }

  static double passwordToggleHeight(GbInputSize size) {
    switch (size) {
      case GbInputSize.sm:
        return 36;
      case GbInputSize.md:
        return 40;
    }
  }

  static const double passwordToggleSpacing = 4;

  /// Whether the content should be vertically centered by default.
  static const bool defaultVerticalCentering = true;
}
