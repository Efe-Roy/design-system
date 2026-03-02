import 'package:flutter/material.dart';
export 'gb_badge_types.dart';
import 'gb_badge_base.dart';
import 'gb_badge_types.dart';

class GbBadge extends StatelessWidget {
  const GbBadge({
    super.key,
    required this.label,
    this.type = GbBadgeType.pillColor,
    this.size = GbBadgeSize.md,
    this.color = GbBadgeColor.gray,
    this.icon = GbBadgeIcon.none, // 👈 RENAMED (was iconType)
    this.customIcon,
    this.onRemove,
  }) : assert(
         // Validation: If the icon type requires content (Avatar, Flag, Icon),
         // ensure the developer provided the 'customIcon' widget.
         (icon == GbBadgeIcon.avatar ||
                 icon == GbBadgeIcon.country ||
                 icon == GbBadgeIcon.iconLeading ||
                 icon == GbBadgeIcon.iconTrailing ||
                 icon == GbBadgeIcon.only)
             ? customIcon != null
             : true,
         'GbBadge: You selected an icon type ($icon) but did not provide the "customIcon" widget.',
       );

  /// The text displayed inside the badge
  final String label;

  /// Visual style: Pill vs Badge, Outline vs Filled
  final GbBadgeType type;

  /// Size: sm, md, lg
  final GbBadgeSize size;

  /// Semantic Color intent (Gray, Primary, Success, etc.)
  final GbBadgeColor color;

  /// The variant logic (Dot, Avatar, xClose, etc.)
  final GbBadgeIcon icon; // 👈 RENAMED (was iconType)

  /// The widget content for the slot (Avatar, Flag, SVG, Icon)
  /// Required if [icon] is set to avatar, country, or generic icon.
  final Widget? customIcon;

  /// Callback for the 'xClose' icon tap.
  /// Only used if [icon] is set to GbBadgeIcon.xClose.
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return GbBadgeBase(
      label: label,
      type: type,
      size: size,
      color: color,
      icon: icon, // 👈 Passing the correct property
      customIcon: customIcon,
      onRemove: onRemove,
    );
  }
}
