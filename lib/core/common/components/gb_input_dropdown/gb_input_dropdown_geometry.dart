import 'package:design_system/core/common/constants/gb_radius.dart';
import 'package:design_system/core/common/constants/gb_spacing.dart';
import 'gb_input_dropdown_types.dart';

class GbInputDropdownGeometry {
  const GbInputDropdownGeometry._();

  // ===========================================================================
  //  TRIGGER BUTTON GEOMETRY
  // ===========================================================================
  static double height(GbInputDropdownSize size) =>
      size == GbInputDropdownSize.sm ? 40.0 : 48.0;
  static double borderRadius(GbInputDropdownSize size) => GlobusRadius.sm;
  static double paddingHorizontal(GbInputDropdownSize size) =>
      GlobusSpacing.spacing3;

  static const double labelToFieldSpacing = GlobusSpacing.spacing2;
  static const double fieldToHintSpacing = GlobusSpacing.spacing2;
  static const double contentGap = GlobusSpacing.spacing2;
  static const double trailingIconGap = GlobusSpacing.spacing6;

  static const double leadingIconSize = 20.0;
  static const double dotSize = 8.0;
  static const double chevronSize = 10.0;
  static const double flagIconSize = 24.0;
  static const double checkmarkSize = 20.0;

  // ===========================================================================
  //  MODAL GEOMETRY
  // ===========================================================================
  static const double modalAbsoluteMaxHeight = 844.0; // Figma spec
  static const double modalPaddingOuter =
      GlobusSpacing.spacing2; // 8px around the content box
  static const double modalBorderRadius = GlobusRadius.lg;

  // Header Box (Title & Search)
  static const double headerPaddingHorizontal = GlobusSpacing.spacing4; // 16px
  static const double headerPaddingVertical = GlobusSpacing.spacing1; // 4px
  static const double titleBottomPadding = GlobusSpacing.spacing4; // 16px

  static const double dragHandleWidth = 32.0;
  static const double dragHandleHeight = 4.0;
  static const double dragHandleTopMargin = GlobusSpacing.spacing2; // 8px

  // ===========================================================================
  //  MENU ITEM GEOMETRY (The 3-Layer Architecture)
  // ===========================================================================
  // Layer 1: Mother Container
  static const double itemMotherPaddingHorizontal = GlobusSpacing.spacing4;

  // Layer 2: Divider Container
  static const double itemDividerPaddingVertical = GlobusSpacing.spacing2;
  static const double itemBorderWidth = 0.7;

  // Layer 3: Content Container
  static const double itemContentPadding = GlobusSpacing.spacing2; // 8px
  static const double itemContentBorderRadius = GlobusRadius.xs;
  static const double itemContentMinHeight = 40.0;

  // Content Spacing
  static const double itemLeadingToTextSpacing = GlobusSpacing.spacing2;
  static const double itemTextToSupportingTextSpacing = GlobusSpacing.spacing2;
  static const double itemTextToCheckmarkSpacing = GlobusSpacing.spacing4;
}
