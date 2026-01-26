import 'package:flutter/material.dart';
import 'gb_avatar_types.dart';

/// Pure geometry configuration for avatar overlays.
/// NO colors, NO widgets, NO SVG knowledge.
@immutable
class GbAvatarOverlayLayout {
  /// Width == height of the overlay container
  final double size;

  /// How much the overlay overlaps INTO the avatar
  final double overlap;

  /// Whether the avatar circle should be clipped
  final bool clipAvatar;

  const GbAvatarOverlayLayout({
    required this.size,
    required this.overlap,
    required this.clipAvatar,
  });

  /// Convenience getter for Positioned()
  Offset get offset => Offset(-overlap, -overlap);
}

/// Resolves overlay geometry based on avatar size + overlay type
GbAvatarOverlayLayout resolveAvatarOverlayLayout({
  required GbAvatarSize avatarSize,
  required GbAvatarOverlayType overlay,
}) {
  GbAvatarOverlayLayout layout({
    required double size,
    required double overlap,
    required bool clip,
  }) => GbAvatarOverlayLayout(size: size, overlap: overlap, clipAvatar: clip);

  switch (avatarSize) {
    case GbAvatarSize.xxs:
      switch (overlay) {
        case GbAvatarOverlayType.status:
          return layout(size: 6, overlap: 1, clip: true);
        case GbAvatarOverlayType.company:
          return layout(size: 7, overlap: 2, clip: true);
        case GbAvatarOverlayType.verified:
          return layout(size: 6, overlap: 1, clip: false);
      }

    case GbAvatarSize.xs:
      switch (overlay) {
        case GbAvatarOverlayType.status:
          return layout(size: 6, overlap: 0.5, clip: true);
        case GbAvatarOverlayType.company:
          return layout(size: 11, overlap: 4, clip: true);
        case GbAvatarOverlayType.verified:
          return layout(size: 10, overlap: 3, clip: false);
      }

    case GbAvatarSize.sm:
      switch (overlay) {
        case GbAvatarOverlayType.status:
          return layout(size: 8, overlap: 1, clip: true);
        case GbAvatarOverlayType.company:
          return layout(size: 13, overlap: 4, clip: true);
        case GbAvatarOverlayType.verified:
          return layout(size: 12, overlap: 3, clip: false);
      }

    case GbAvatarSize.md:
      switch (overlay) {
        case GbAvatarOverlayType.status:
          return layout(size: 10, overlap: 1, clip: true);
        case GbAvatarOverlayType.company:
          return layout(size: 15, overlap: 4, clip: true);
        case GbAvatarOverlayType.verified:
          return layout(size: 14, overlap: 3, clip: false);
      }

    case GbAvatarSize.lg:
      switch (overlay) {
        case GbAvatarOverlayType.status:
          return layout(size: 12, overlap: 2, clip: true);
        case GbAvatarOverlayType.company:
          return layout(size: 18, overlap: 5, clip: true);
        case GbAvatarOverlayType.verified:
          return layout(size: 16, overlap: 2, clip: false);
      }

    case GbAvatarSize.xl:
      switch (overlay) {
        case GbAvatarOverlayType.status:
          return layout(size: 14, overlap: 2, clip: true);
        case GbAvatarOverlayType.company:
          return layout(size: 20, overlap: 5, clip: true);
        case GbAvatarOverlayType.verified:
          return layout(size: 18, overlap: 1, clip: false);
      }

    case GbAvatarSize.xxl:
      switch (overlay) {
        case GbAvatarOverlayType.status:
          return layout(size: 16, overlap: 1, clip: true);
        case GbAvatarOverlayType.company:
          return layout(size: 20, overlap: 4, clip: true);
        case GbAvatarOverlayType.verified:
          return layout(size: 20, overlap: 2, clip: false);
      }
  }
}
