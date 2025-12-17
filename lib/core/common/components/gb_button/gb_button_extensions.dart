import 'package:flutter/material.dart';
import 'package:design_system/blocs/theme/gb_radius.dart';
import 'gb_button_types.dart';

extension GbButtonHierarchyX on GbButtonHierarchy {
  bool get isLink {
    switch (this) {
      case GbButtonHierarchy.linkGray:
      case GbButtonHierarchy.linkColor:
        return true;
      default:
        return false;
    }
  }

  /// Border radius resolved from design tokens
  BorderRadius get borderRadius {
    switch (this) {
      case GbButtonHierarchy.linkGray:
      case GbButtonHierarchy.linkColor:
        return BorderRadius.circular(GlobusRadius.none);

      default:
        return BorderRadius.circular(GlobusRadius.sm);
    }
  }
}
