import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gb_badge_types.dart';
import 'gb_badge_geometry.dart';
import 'gb_badge_tokens.dart';

// ─────────────────────────────────────────────────────────────
// 🔒 PRIVATE WIDGET: The "Unpublished" X Button
// ─────────────────────────────────────────────────────────────
class _GbBadgeCloseButton extends StatelessWidget {
  const _GbBadgeCloseButton({required this.color, required this.onTap});

  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // We wrap it in a GestureDetector with "opaque" behavior
    // This ensures that even if the user taps slightly outside the visible pixels,
    // it still registers the tap (Figma "Hit Area" logic).
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icons/xClose.svg',
          width: GbBadgeGeometry.genericIconSize, // 12px
          height: GbBadgeGeometry.genericIconSize,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 🧱 BASE COMPONENT (The Engine)
// ─────────────────────────────────────────────────────────────
class GbBadgeBase extends StatelessWidget {
  const GbBadgeBase({
    super.key,
    required this.label,
    required this.type,
    required this.size,
    required this.color,
    required this.icon,
    this.customIcon,
    this.onRemove,
  });

  final String label;
  final GbBadgeType type;
  final GbBadgeSize size;
  final GbBadgeColor color;
  final GbBadgeIcon icon;
  final Widget? customIcon;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final config = GbBadgeTokens.resolve(
      context: context,
      type: type,
      color: color,
      icon: icon,
    );

    final double height = GbBadgeGeometry.height(size);
    final EdgeInsets padding = GbBadgeGeometry.padding(size);
    final TextStyle fontStyle = GbBadgeGeometry.textStyle(size);
    final BorderRadius radius = GbBadgeGeometry.borderRadius(type);
    final double borderWidth = (type == GbBadgeType.pillOutline) ? 1.5 : 1.0;

    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: config.background,
        borderRadius: radius,
        border: config.border != null
            ? Border.all(color: config.border!, width: borderWidth)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── LEADING SLOT (The Niche) ───
          if (icon != GbBadgeIcon.none) ...[
            _buildLeadingSlot(
              config,
            ), // 👈 Places the content into the geometry slot
            if (icon != GbBadgeIcon.only)
              SizedBox(
                width: icon == GbBadgeIcon.iconLeading
                    ? GbBadgeGeometry.gapIconLeading
                    : GbBadgeGeometry.gapStandard,
              ),
          ],
          // ─── LABEL SLOT ───
          if (icon != GbBadgeIcon.only)
            Text(
              label,
              style: fontStyle.copyWith(color: config.text, height: 1.0),
            ),

          // ─── TRAILING SLOT ───
          if (icon == GbBadgeIcon.iconTrailing) ...[
            const SizedBox(width: GbBadgeGeometry.gapIconTrailing),
            _buildIcon(
              icon: customIcon,
              size: GbBadgeGeometry.genericIconSize,
              color: config.icon,
            ),
          ],

          // ─── CLOSE BUTTON (The Unpublished Widget) ───
          if (icon == GbBadgeIcon.xClose) ...[
            const SizedBox(width: GbBadgeGeometry.gapXClose),
            _GbBadgeCloseButton(
              // 👈 Usage of the private widget
              color: config.icon,
              onTap: onRemove,
            ),
          ],
        ],
      ),
    );
  }

  /// 🏗️ The Slot Builder
  /// This creates the "Niche" with the exact pixel dimensions from Figma,
  /// then drops the [customIcon] inside it.
  Widget _buildLeadingSlot(GbBadgeColorConfig config) {
    switch (icon) {
      case GbBadgeIcon.dot:
        // Internal geometry (no external widget needed)
        return Container(
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: config.icon, shape: BoxShape.circle),
        );

      case GbBadgeIcon.avatar:
        // 📏 SLOT: 18px x 18px
        return SizedBox(
          width: GbBadgeGeometry.avatarSize,
          height: GbBadgeGeometry.avatarSize,
          child: customIcon, // 📺 CONTENT: The Avatar Widget
        );

      case GbBadgeIcon.country:
        // 📏 SLOT: 18px x 18px
        return SizedBox(
          width: GbBadgeGeometry.countryIconSize,
          height: GbBadgeGeometry.countryIconSize,
          child: customIcon, // 📺 CONTENT: The Flag Widget
        );

      case GbBadgeIcon.iconLeading:
      case GbBadgeIcon.only:
        return _buildIcon(
          icon: customIcon,
          size: GbBadgeGeometry.genericIconSize,
          color: config.icon,
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildIcon({
    Widget? icon,
    required double size,
    required Color color,
  }) {
    if (icon == null) return const SizedBox.shrink();

    // 🛠️ FIX: Wrap in ColorFiltered to force SVGs to obey the color token
    return IconTheme(
      data: IconThemeData(size: size, color: color),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        child: icon,
      ),
    );
  }
}
