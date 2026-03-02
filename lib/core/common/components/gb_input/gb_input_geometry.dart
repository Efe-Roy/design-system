import 'package:flutter/material.dart';

import 'gb_input_types.dart';
import 'package:design_system/core/common/constants/gb_spacing.dart';

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

  /// Whether an input type renders multiple visual segments.
  ///
  /// IMPORTANT:
  /// This refers only to **visually segmented** inputs
  /// (i.e. internal divider + separate bordered areas).
  static bool isSegmented(GbInputType type) {
    switch (type) {
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

  static double leadingIconSize(GbInputType type) {
    switch (type) {
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

  // ─────────────────────────────────────────────
  // PASSWORD INPUT
  // ─────────────────────────────────────────────

  // Spacing between the Help/Error icon and the "SHOW" button
  static const double passwordIconToTextSpacing = 8.0;

  // The touch target width for the "SHOW" button.
  // The text is centered within this space.
  static const double passwordShowButtonWidth = 72.0;

  // Spacing between the text input and the Help/Error icon
  static const double passwordContentToIconSpacing = 8.0;

  // static const double passwordToggleSpacing = 4;

  // ─────────────────────────────────────────────
  // PASSWORD ICON LEADING SPECIFIC
  // ─────────────────────────────────────────────
  static const double passwordLeadingIconSize = 20.0;
  static const double passwordLeadingIconToTextSpacing = 8.0;

  // ─────────────────────────────────────────────
  // ICON LEADING / CLEAR BUTTON SPECIFIC
  // ─────────────────────────────────────────────
  static const double clearButtonSize = 11.67;
  static const double helpToClearButtonSpacing = 22.12;
  static const double textToTrailingIconSpacing =
      8.0; // Shared with others usually, but defining specific here for clarity

  // ─────────────────────────────────────────────
  // LEADING DROPDOWN SPECIFIC
  // ─────────────────────────────────────────────
  static const double dropdownLeadingIconSize = 24.0; // Flag width/height
  static const double dropdownArrowWidth = 5.0; // 5px width
  static const double dropdownArrowHeight = 10.0; // 10px height

  static const double dropdownIconToTextSpacing = 4.0;
  static const double dropdownTextToArrowSpacing = 9.0;
  static const double dropdownArrowToFieldSpacing = 16.0;

  // ─────────────────────────────────────────────
  // PAYMENT SPECIFIC
  // ─────────────────────────────────────────────
  static const double paymentIconWidth = 34.0;
  static const double paymentIconHeight = 24.0;
  static const double paymentIconToTextSpacing = 8.0;

  // ───────── TRAILING DROPDOWN SPACING ─────────

  /// Distance between the leading text ("$") and the input field
  static const double trailingLeadingTextToFieldSpacing = 8.0;

  /// Distance between the input field and the Help/Error icon
  static const double trailingFieldToIconSpacing = 8.0;

  /// Distance between the Help/Error icon and the Dropdown trigger ("USD")
  static const double trailingIconToDropdownSpacing = 4.0;

  // ───────── TAGS / CHIPS SPACING ─────────

  static const double chipHeight = 24.0;
  static const double chipBorderRadius = 4.0;

  /// Padding inside the chip (Left/Right)
  static const double chipPaddingHorizontal = 4.0;

  /// Gap between chips
  static const double chipGap = 6.0;

  /// Size of the avatar inside the chip
  static const double chipAvatarSize = 18.0;

  /// Size of the close 'x' icon
  static const double chipCloseIconSize = 5.83;

  /// Space between avatar and text, or text and close icon
  static const double chipContentSpacing = 4.0;

  /// Vertical spacing for the Wrap widget to separate lines of chips
  static const double chipRunSpacing = 6.0;

  /// Whether the content should be vertically centered by default.
  static const bool defaultVerticalCentering = true;
}
