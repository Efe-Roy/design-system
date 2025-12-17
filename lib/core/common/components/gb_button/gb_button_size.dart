import 'package:flutter/material.dart';
import 'package:design_system/blocs/theme/gb_spacing.dart';
import 'package:design_system/blocs/theme/gb_text_style.dart';
import 'gb_button_files.dart';

class GbButtonSizeConfig {
  final double? height;
  final EdgeInsets padding;
  final double gap;
  final TextStyle textStyle;
  final double iconSize;

  const GbButtonSizeConfig({
    required this.height,
    required this.padding,
    required this.gap,
    required this.textStyle,
    required this.iconSize,
  });
}

GbButtonSizeConfig resolveButtonSize(GbButtonSize size) {
  switch (size) {
    case GbButtonSize.sm:
      return const GbButtonSizeConfig(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: GlobusSpacing.spacing3),
        gap: GlobusSpacing.spacing2,
        textStyle: GlobusTypography.textSmSemiBold,
        iconSize: 20,
      );

    case GbButtonSize.md:
      return const GbButtonSizeConfig(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: GlobusSpacing.spacing4),
        gap: GlobusSpacing.spacing2,
        textStyle: GlobusTypography.textSmSemiBold,
        iconSize: 20,
      );

    case GbButtonSize.lg:
      return const GbButtonSizeConfig(
        height: 44,
        padding: EdgeInsets.symmetric(horizontal: GlobusSpacing.spacing4),
        gap: GlobusSpacing.spacing2,
        textStyle: GlobusTypography.textMdSemiBold,
        iconSize: 20,
      );

    case GbButtonSize.xl:
      return const GbButtonSizeConfig(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: GlobusSpacing.spacing5),
        gap: GlobusSpacing.spacing2,
        textStyle: GlobusTypography.textMdSemiBold,
        iconSize: 20,
      );

    case GbButtonSize.xxl:
      return const GbButtonSizeConfig(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: GlobusSpacing.spacing6),
        gap: GlobusSpacing.spacing2,
        textStyle: GlobusTypography.textLgSemiBold,
        iconSize: 24,
      );
  }
}
