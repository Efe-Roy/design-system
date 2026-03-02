import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'gb_input_dropdown_types.dart';
import 'gb_input_dropdown_geometry.dart';
import 'gb_input_dropdown_tokens.dart';

class GbInputDropdownMenuItem<T> extends StatefulWidget {
  const GbInputDropdownMenuItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.type,
  });

  final GbInputDropdownItem<T> item;
  final bool isSelected;
  final VoidCallback onTap;
  final GbInputDropdownType type;

  @override
  State<GbInputDropdownMenuItem<T>> createState() =>
      _GbInputDropdownMenuItemState();
}

class _GbInputDropdownMenuItemState<T>
    extends State<GbInputDropdownMenuItem<T>> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.item.enabled && mounted) setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.item.enabled && mounted) {
      setState(() => _isPressed = false);
      widget.onTap();
    }
  }

  void _handleTapCancel() {
    if (widget.item.enabled && mounted) setState(() => _isPressed = false);
  }

  Widget _buildLeadingWidget(Color iconColor) {
    if (widget.type == GbInputDropdownType.normal &&
        widget.item.countryCode != null) {
      return SvgPicture.asset(
        'assets/icons/flags/${widget.item.countryCode!.toLowerCase()}.svg',
        width: GbInputDropdownGeometry.flagIconSize,
        height: GbInputDropdownGeometry.flagIconSize,
      );
    }

    if (widget.item.leading != null) {
      if (widget.type == GbInputDropdownType.iconLeading) {
        return IconTheme(
          data: IconThemeData(
            size: GbInputDropdownGeometry.leadingIconSize,
            color: iconColor,
          ),
          child: widget.item.leading!,
        );
      }
      return widget.item.leading!;
    }

    if (widget.type == GbInputDropdownType.dotLeading &&
        widget.item.dotColor != null) {
      return Container(
        width: GbInputDropdownGeometry.dotSize,
        height: GbInputDropdownGeometry.dotSize,
        decoration: BoxDecoration(
          color: widget.item.dotColor,
          shape: BoxShape.circle,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    // Determine dynamic colors based on state
    final bgColor = GbInputDropdownTokens.itemBackgroundColor(
      context,
      isSelected: widget.isSelected,
      isPressed: _isPressed,
      isEnabled: widget.item.enabled,
    );
    final iconColor = GbInputDropdownTokens.itemLeadingIconColor(
      context,
      isEnabled: widget.item.enabled,
    );

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: Container(
        // LAYER 1: Mother Container (Outer Spacing)
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: GbInputDropdownGeometry.itemMotherPaddingHorizontal,
        ),
        child: Container(
          // LAYER 2: Divider Container (Border & Vertical Spacing)
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: GbInputDropdownGeometry.itemDividerPaddingVertical,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: GbInputDropdownTokens.itemDividerColor(context),
                width: GbInputDropdownGeometry.itemBorderWidth, // Strict 0.7px
              ),
            ),
          ),
          child: Container(
            // LAYER 3: Interactive Content Container (Color, Radius & Content)
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: GbInputDropdownGeometry.itemContentMinHeight,
            ),
            padding: const EdgeInsets.all(
              GbInputDropdownGeometry.itemContentPadding,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(
                GbInputDropdownGeometry.itemContentBorderRadius,
              ),
            ),
            child: Row(
              children: [
                // Leading Display
                _buildLeadingWidget(iconColor),

                if (widget.item.leading != null ||
                    widget.item.countryCode != null ||
                    widget.item.dotColor != null)
                  const SizedBox(
                    width: GbInputDropdownGeometry.itemLeadingToTextSpacing,
                  ),

                // Text Content
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.item.text,
                          style: GbInputDropdownTokens.itemTitleTextStyle(
                            context,
                            isEnabled: widget.item.enabled,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.item.supportingText != null) ...[
                        const SizedBox(
                          width: GbInputDropdownGeometry
                              .itemTextToSupportingTextSpacing,
                        ),
                        Text(
                          widget.item.supportingText!,
                          style: GbInputDropdownTokens.itemSupportingTextStyle(
                            context,
                            isEnabled: widget.item.enabled,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // Checkmark
                if (widget.isSelected) ...[
                  const SizedBox(
                    width: GbInputDropdownGeometry.itemTextToCheckmarkSpacing,
                  ),
                  SvgPicture.asset(
                    'assets/icons/check.svg',
                    width: GbInputDropdownGeometry.checkmarkSize,
                    height: GbInputDropdownGeometry.checkmarkSize,
                    colorFilter: ColorFilter.mode(
                      widget.item.enabled
                          ? GbInputDropdownTokens.checkmarkColor(context)
                          : iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
