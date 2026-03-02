import 'package:flutter/material.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';
import 'gb_avatar_types.dart';

/// Holds all size-dependent configuration for an avatar
class GbAvatarSizeConfig {
  /// Diameter of the avatar circle
  final double diameter;

  /// Text style for initials avatars
  final TextStyle initialsTextStyle;

  /// Padding used when rendering initials
  final EdgeInsets initialsPadding;

  /// Size of the status indicator dot
  final double statusDotSize;

  /// Border width of the status indicator dot
  final double statusDotBorderWidth;

  /// Offset used to position the status indicator relative to avatar
  final Offset statusDotOffset;

  /// Size of badge icons (verified / company)
  final double verifiedBadgeSize;
  final double companyBadgeSize;

  const GbAvatarSizeConfig({
    required this.diameter,
    required this.initialsTextStyle,
    required this.initialsPadding,
    required this.statusDotSize,
    required this.statusDotBorderWidth,
    required this.statusDotOffset,
    required this.verifiedBadgeSize,
    required this.companyBadgeSize,
  });
}

/// Resolves avatar size configuration from design tokens
GbAvatarSizeConfig resolveAvatarSize(GbAvatarSize size) {
  switch (size) {
    case GbAvatarSize.xxs:
      return GbAvatarSizeConfig(
        diameter: 18,
        initialsTextStyle: GlobusTypography.textXxsSemiBold.copyWith(
          fontSize: 8,
        ),
        initialsPadding: EdgeInsets.symmetric(horizontal: 1),
        statusDotSize: 4,
        statusDotBorderWidth: 1,
        statusDotOffset: Offset(1, 1),
        verifiedBadgeSize: 6,
        companyBadgeSize: 4,
      );

    case GbAvatarSize.xs:
      return const GbAvatarSizeConfig(
        diameter: 24,
        initialsTextStyle: GlobusTypography.textXsSemiBold,
        initialsPadding: EdgeInsets.symmetric(horizontal: 1),
        statusDotSize: 6,
        statusDotBorderWidth: 1.5,
        statusDotOffset: Offset(1.5, 1.5),
        verifiedBadgeSize: 10,
        companyBadgeSize: 10,
      );

    case GbAvatarSize.sm:
      return const GbAvatarSizeConfig(
        diameter: 32,
        initialsTextStyle: GlobusTypography.textSmSemiBold,
        initialsPadding: EdgeInsets.symmetric(horizontal: 1),
        statusDotSize: 8,
        statusDotBorderWidth: 1.5,
        statusDotOffset: Offset(2, 2),
        verifiedBadgeSize: 12,
        companyBadgeSize: 12,
      );

    case GbAvatarSize.md:
      return const GbAvatarSizeConfig(
        diameter: 40,
        initialsTextStyle: GlobusTypography.textMdSemiBold,
        initialsPadding: EdgeInsets.symmetric(horizontal: 2),
        statusDotSize: 10,
        statusDotBorderWidth: 1.5,
        statusDotOffset: Offset(2.5, 2.5),
        verifiedBadgeSize: 14,
        companyBadgeSize: 14,
      );

    case GbAvatarSize.lg:
      return const GbAvatarSizeConfig(
        diameter: 48,
        initialsTextStyle: GlobusTypography.textLgSemiBold,
        initialsPadding: EdgeInsets.symmetric(horizontal: 2),
        statusDotSize: 12,
        statusDotBorderWidth: 1.5,
        statusDotOffset: Offset(3, 3),
        verifiedBadgeSize: 16,
        companyBadgeSize: 16,
      );

    case GbAvatarSize.xl:
      return const GbAvatarSizeConfig(
        diameter: 56,
        initialsTextStyle: GlobusTypography.textXlSemiBold,
        initialsPadding: EdgeInsets.symmetric(horizontal: 2),
        statusDotSize: 14,
        statusDotBorderWidth: 1.5,
        statusDotOffset: Offset(3.5, 3.5),
        verifiedBadgeSize: 18,
        companyBadgeSize: 18,
      );

    case GbAvatarSize.xxl:
      return const GbAvatarSizeConfig(
        diameter: 64,
        initialsTextStyle: GlobusTypography.displayXsSemiBold,
        initialsPadding: EdgeInsets.symmetric(horizontal: 2),
        statusDotSize: 16,
        statusDotBorderWidth: 1.5,
        statusDotOffset: Offset(4, 4),
        verifiedBadgeSize: 20,
        companyBadgeSize: 20,
      );
  }
}
