import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gb_avatar_types.dart';
import 'gb_avatar_size.dart';
import 'gb_avatar_colors.dart';
import 'gb_avatar_badge_layout.dart';
import 'package:design_system/blocs/theme/gb_semantic_tokens.dart';

class GbAvatar extends StatelessWidget {
  final GbAvatarSize size;
  final GbAvatarState state;
  final GbAvatarColor color;

  /// Content (exactly one required)
  final ImageProvider? image;
  final String? initials;
  final bool normal;

  /// Presence
  final GbAvatarStatus status;

  /// Symbolic badge
  final GbAvatarBadge badge;

  /// Optional override for COMPANY badge only
  /// If null → default company badge SVG is used
  final String? companyBadgeAsset;

  const GbAvatar({
    super.key,
    required this.size,
    this.state = GbAvatarState.defaultState,
    this.color = GbAvatarColor.gray,
    this.image,
    this.initials,
    this.normal = false,
    this.status = GbAvatarStatus.none,
    this.badge = GbAvatarBadge.none,
    this.companyBadgeAsset,
  }) : assert(
         // Exactly ONE content type
         (image != null ? 1 : 0) +
                 (initials != null ? 1 : 0) +
                 (normal ? 1 : 0) ==
             1,
         'GbAvatar: Exactly one content type (image, initials, or normal) must be provided.',
       ),
       assert(
         // Never stack overlay types
         status == GbAvatarStatus.none || badge == GbAvatarBadge.none,
         'GbAvatar: Status and badge cannot be shown at the same time.',
       ),
       assert(
         // Verified badge only allowed for image avatars
         badge != GbAvatarBadge.verified || image != null,
         'GbAvatar: Verified badge is only allowed for image avatars.',
       );

  @override
  Widget build(BuildContext context) {
    final semanticColors = SemanticColors.of(context);
    final sizeConfig = resolveAvatarSize(size);
    final colorConfig = resolveAvatarColors(
      colors: semanticColors,
      variant: color,
      state: state,
      contrastBorder: false,
    );

    /// Determine overlay type (GEOMETRY)
    final GbAvatarOverlayType? overlayType = _resolveOverlayType();

    /// Resolve overlay layout if needed
    final GbAvatarOverlayLayout? overlayLayout = overlayType != null
        ? resolveAvatarOverlayLayout(avatarSize: size, overlay: overlayType)
        : null;

    return SizedBox(
      width: sizeConfig.diameter,
      height: sizeConfig.diameter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --------------------------------------------------------------
          // Avatar base
          // --------------------------------------------------------------
          ClipOval(
            clipBehavior: overlayLayout?.clipAvatar == true
                ? Clip.hardEdge
                : Clip.none,
            child: Container(
              width: sizeConfig.diameter,
              height: sizeConfig.diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: image == null ? colorConfig.background : null,
                border: colorConfig.border != null
                    ? Border.all(color: colorConfig.border!)
                    : null,
              ),
              alignment: Alignment.center,
              child: _buildAvatarContent(sizeConfig, colorConfig),
            ),
          ),

          // --------------------------------------------------------------
          // Status dot (online / offline)
          // --------------------------------------------------------------
          if (overlayType == GbAvatarOverlayType.status &&
              overlayLayout != null)
            Positioned(
              right: overlayLayout.offset.dx,
              bottom: overlayLayout.offset.dy,
              child: _buildStatusDot(
                size: overlayLayout.size,
                isOnline: status == GbAvatarStatus.online,
                colors: colorConfig,
              ),
            ),

          // --------------------------------------------------------------
          // Badge (verified / company)
          // --------------------------------------------------------------
          if (overlayType == GbAvatarOverlayType.company ||
              overlayType == GbAvatarOverlayType.verified)
            Positioned(
              right: overlayLayout!.offset.dx,
              bottom: overlayLayout.offset.dy,
              child: _buildBadge(badge: badge, size: overlayLayout.size),
            ),
        ],
      ),
    );
  }

  // ===================================================================
  // Overlay resolution
  // ===================================================================

  GbAvatarOverlayType? _resolveOverlayType() {
    if (status != GbAvatarStatus.none) {
      return GbAvatarOverlayType.status;
    }

    if (badge == GbAvatarBadge.company) {
      return GbAvatarOverlayType.company;
    }

    if (badge == GbAvatarBadge.verified) {
      return GbAvatarOverlayType.verified;
    }

    return null;
  }

  // ===================================================================
  // Avatar content
  // ===================================================================

  Widget _buildAvatarContent(
    GbAvatarSizeConfig sizeConfig,
    GbAvatarColors colorConfig,
  ) {
    // 1️⃣ normal wins
    if (normal) {
      return Icon(
        Icons.person,
        size: sizeConfig.diameter * 0.5,
        color: colorConfig.foreground,
      );
    }

    // 2️⃣ Image
    if (image != null) {
      return ClipOval(
        child: Image(
          image: image!,
          width: sizeConfig.diameter,
          height: sizeConfig.diameter,
          fit: BoxFit.cover,
        ),
      );
    }

    // 3️⃣ Initials
    if (initials != null && initials!.isNotEmpty) {
      return Padding(
        padding: sizeConfig.initialsPadding,
        child: Center(
          child: Text(
            initials!,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: sizeConfig.initialsTextStyle.copyWith(
              color: colorConfig.foreground,
              height: 1, // locked & stable
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  // ===================================================================
  // Status dot
  // ===================================================================

  Widget _buildStatusDot({
    required double size,
    required bool isOnline,
    required GbAvatarColors colors,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOnline ? colors.statusBackground : colors.background,
        border: Border.all(color: colors.statusBorder, width: 1.5),
      ),
    );
  }

  // ===================================================================
  // Badge (SVG)
  // ===================================================================

  Widget _buildBadge({required GbAvatarBadge badge, required double size}) {
    final String assetPath = badge == GbAvatarBadge.verified
        ? 'assets/icons/verifyBadge.svg'
        : (companyBadgeAsset ?? 'assets/icons/companyLogo.svg');

    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(assetPath, fit: BoxFit.contain),
    );
  }
}
