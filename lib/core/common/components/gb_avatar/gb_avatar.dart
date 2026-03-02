import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gb_avatar_types.dart';
import 'gb_avatar_geometry.dart';
import 'gb_avatar_tokens.dart';
import 'gb_avatar_badge_layout.dart';
import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';

class GbAvatar extends StatelessWidget {
  final GbAvatarSize size;
  final GbAvatarState state;
  final GbAvatarColor color;

  /// Content Options
  final ImageProvider? image;
  final String? initials;

  /// If true, forces the generic user icon.
  final bool placeholder;

  /// Presence
  final GbAvatarStatus status;

  /// Symbolic badge
  final GbAvatarBadge badge;

  /// Optional override for COMPANY badge only
  final String? companyBadgeAsset;

  const GbAvatar({
    super.key,
    required this.size,
    this.state = GbAvatarState.defaultState,
    this.color = GbAvatarColor.gray,
    this.image,
    this.initials,
    this.placeholder = false,
    this.status = GbAvatarStatus.none,
    this.badge = GbAvatarBadge.none,
    this.companyBadgeAsset,
  }) : assert(
         // Safety check: Status and Badge can't coexist
         status == GbAvatarStatus.none || badge == GbAvatarBadge.none,
         'GbAvatar: Status and badge cannot be shown at the same time.',
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

    final GbAvatarOverlayType? overlayType = _resolveOverlayType();

    final GbAvatarOverlayLayout? overlayLayout = overlayType != null
        ? resolveAvatarOverlayLayout(avatarSize: size, overlay: overlayType)
        : null;

    return SizedBox(
      width: sizeConfig.diameter,
      height: sizeConfig.diameter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Avatar Base
          ClipOval(
            clipBehavior: overlayLayout?.clipAvatar == true
                ? Clip.hardEdge
                : Clip.none,
            child: Container(
              width: sizeConfig.diameter,
              height: sizeConfig.diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorConfig.background,
                border: colorConfig.border != null
                    ? Border.all(color: colorConfig.border!)
                    : null,
              ),
              alignment: Alignment.center,
              child: _buildAvatarContent(sizeConfig, colorConfig),
            ),
          ),

          // Status Dot
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

          // Badge
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

  GbAvatarOverlayType? _resolveOverlayType() {
    if (status != GbAvatarStatus.none) return GbAvatarOverlayType.status;
    if (badge == GbAvatarBadge.company) return GbAvatarOverlayType.company;
    if (badge == GbAvatarBadge.verified) return GbAvatarOverlayType.verified;
    return null;
  }

  // 🧠 CONTENT BUILDER (Updated)
  Widget _buildAvatarContent(
    GbAvatarSizeConfig sizeConfig,
    GbAvatarColors colorConfig,
  ) {
    // 1️⃣ Placeholder Wins (Matches Figma "Placeholder" state)
    if (placeholder) {
      return Icon(
        Icons.person,
        size: sizeConfig.diameter * 0.5,
        color: colorConfig.foreground,
      );
    }

    // 2️⃣ Try Image
    if (image != null) {
      return ClipOval(
        child: Image(
          image: image!,
          width: sizeConfig.diameter,
          height: sizeConfig.diameter,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildInitialsOrIcon(sizeConfig, colorConfig);
          },
        ),
      );
    }

    // 3️⃣ Fallback (Initials or Icon)
    return _buildInitialsOrIcon(sizeConfig, colorConfig);
  }

  Widget _buildInitialsOrIcon(
    GbAvatarSizeConfig sizeConfig,
    GbAvatarColors colorConfig,
  ) {
    if (initials != null && initials!.isNotEmpty) {
      final String displayText = _processInitials(initials!);

      return Padding(
        padding: sizeConfig.initialsPadding,
        child: Center(
          child: Text(
            displayText,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: sizeConfig.initialsTextStyle.copyWith(
              color: colorConfig.foreground,
              height: 1,
            ),
          ),
        ),
      );
    }

    return Icon(
      Icons.person,
      size: sizeConfig.diameter * 0.5,
      color: colorConfig.foreground,
    );
  }

  String _processInitials(String input) {
    final text = input.trim();
    if (text.isEmpty) return '';
    if (text.length <= 2) return text.toUpperCase();
    final parts = text.split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

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
