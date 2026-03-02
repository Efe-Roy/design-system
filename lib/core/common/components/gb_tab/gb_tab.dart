import 'package:design_system/core/common/constants/gb_radius.dart';
import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';
import 'package:flutter/material.dart';
import 'package:design_system/core/common/components/gb_badge/gb_badge.dart';
import 'gb_tab_types.dart';
import 'gb_tab_geometry.dart';
import 'gb_tab_tokens.dart';
export 'gb_tab_types.dart';

class GbTab extends StatefulWidget {
  const GbTab({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTabChanged,
    this.badgeLabels,
    this.type = GbTabType.underline,
    this.size = GbTabSize.md,
    this.fullWidth = false, // Merged 50/50 split (Login style)
    this.fillWidth = false, // Spaced equal split (Segmented style)
    this.padding = EdgeInsets.zero,
  });

  final List<String> labels;
  final List<String?>? badgeLabels;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final GbTabType type;
  final GbTabSize size;
  final bool fullWidth;
  final bool fillWidth; // 👈 NEW
  final EdgeInsets padding;

  @override
  State<GbTab> createState() => _GbTabState();
}

class _GbTabState extends State<GbTab> {
  late ScrollController _scrollController;
  bool _showLeftFade = false;
  bool _showRightFade = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateFadeState);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateFadeState());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateFadeState);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateFadeState() {
    if (!_scrollController.hasClients) return;
    final double offset = _scrollController.offset;
    final double maxScroll = _scrollController.position.maxScrollExtent;

    if (maxScroll <= 0) {
      if (_showLeftFade || _showRightFade) {
        setState(() {
          _showLeftFade = false;
          _showRightFade = false;
        });
      }
      return;
    }

    final bool shouldShowLeft = offset > 0;
    final bool shouldShowRight = offset < maxScroll;

    if (shouldShowLeft != _showLeftFade || shouldShowRight != _showRightFade) {
      setState(() {
        _showLeftFade = shouldShowLeft;
        _showRightFade = shouldShowRight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final SemanticColors colors = SemanticColors.of(context);

    final containerTokens = GbTabContainerTokens.resolve(
      type: widget.type,
      colors: colors,
    );

    final EdgeInsets containerPadding = GbTabGeometry.containerPadding(
      widget.type,
    );
    final BorderRadius containerRadius = GbTabGeometry.containerRadius(
      widget.type,
    );

    // Generate Items
    final List<Widget> tabWidgets = List.generate(widget.labels.length, (
      index,
    ) {
      final bool isLast = index == widget.labels.length - 1;
      final String? badgeText =
          (widget.badgeLabels != null && index < widget.badgeLabels!.length)
          ? widget.badgeLabels![index]
          : null;

      final item = _GbTabItem(
        label: widget.labels[index],
        badgeLabel: badgeText,
        type: widget.type,
        size: widget.size,
        current: index == widget.selectedIndex,
        fullWidth:
            widget.fullWidth ||
            widget.fillWidth, // Both modes need the item to expand internally
        onTap: () => widget.onTabChanged(index),
      );

      if (widget.fullWidth) {
        return item; // Returns Expanded
      } else if (widget.fillWidth) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: isLast ? 0.0 : GbTabGeometry.listGap,
            ),
            child: _GbTabItem(
              label: widget.labels[index],
              badgeLabel: badgeText,
              type: widget.type,
              size: widget.size,
              current: index == widget.selectedIndex,
              fullWidth: true, // Tell item to center/fill its container
              onTap: () => widget.onTabChanged(index),
            ),
          ),
        );
      }
      // 3. Scrollable (Standard)
      else {
        return Padding(
          padding: EdgeInsets.only(right: isLast ? 0.0 : GbTabGeometry.listGap),
          child: item,
        );
      }
    });

    Widget content;

    // IF FILL OR FULL -> Use ROW (Non-scrollable, fills space)
    if (widget.fullWidth || widget.fillWidth) {
      content = Row(
        mainAxisSize: MainAxisSize.max, // Force full width
        children: tabWidgets,
      );
    }
    // ELSE -> Use SCROLL VIEW
    else {
      content = LayoutBuilder(
        builder: (context, constraints) {
          return ShaderMask(
            shaderCallback: (Rect bounds) {
              final double fadeWidth = 24.0;
              final double width = bounds.width;
              if (width <= fadeWidth * 2) {
                return const LinearGradient(
                  colors: [Colors.white, Colors.white],
                ).createShader(bounds);
              }

              final double leftStop = _showLeftFade ? (fadeWidth / width) : 0.0;
              final double rightStop = _showRightFade
                  ? (1.0 - (fadeWidth / width))
                  : 1.0;

              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: const [
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0.0, leftStop, rightStop, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(mainAxisSize: MainAxisSize.min, children: tabWidgets),
            ),
          );
        },
      );
    }

    return Padding(
      padding: widget.padding,
      child: Container(
        padding: containerPadding,
        decoration: BoxDecoration(
          color: containerTokens.backgroundColor,
          borderRadius: containerRadius,
          border: containerTokens.borderColor != null
              ? Border.all(color: containerTokens.borderColor!, width: 1.0)
              : (containerTokens.trackLineColor != null)
              ? Border(
                  bottom: BorderSide(
                    color: containerTokens.trackLineColor!,
                    width: 1.0,
                  ),
                )
              : null,
        ),
        child: content,
      ),
    );
  }
}

/// 🔒 Private Internal Component (Mobile Optimized)
class _GbTabItem extends StatelessWidget {
  const _GbTabItem({
    required this.label,
    required this.badgeLabel,
    required this.current,
    required this.type,
    required this.size,
    required this.fullWidth,
    required this.onTap,
  });

  final String label;
  final String? badgeLabel;
  final bool current;
  final GbTabType type;
  final GbTabSize size;
  final bool fullWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final SemanticColors colors = SemanticColors.of(context);
    final token = GbTabTokens.resolve(
      type: type,
      current: current,
      colors: colors,
    );

    // 1. HEIGHT:
    final double height = GbTabGeometry.height(size);

    // 2. PADDING:
    EdgeInsets padding = GbTabGeometry.padding(size);
    if (fullWidth) {
      padding = const EdgeInsets.symmetric(horizontal: 4.0);
    }

    BorderRadius radius = GbTabGeometry.borderRadius(type);
    if (type == GbTabType.roundedButtonWhiteBorder) {
      radius = BorderRadius.circular(GlobusRadius.full);
    }

    // 3. TYPOGRAPHY: Smart Scaling
    // 📱 Mobile Fix: If we are squeezing multiple tabs into the screen,
    // force the text size to 'Small' (14px) so words like "Password" don't truncate.
    final GbTabSize effectiveSize = fullWidth ? GbTabSize.sm : size;
    final TextStyle geometryTextStyle = GbTabGeometry.textStyle(
      effectiveSize,
      current,
    );
    final TextStyle finalTextStyle = geometryTextStyle.copyWith(
      color: token.text,
    );

    Widget? badgeWidget;
    if (badgeLabel != null) {
      badgeWidget = GbBadge(
        label: badgeLabel!,
        type: GbBadgeType.pillColor,
        color: token.badgeColor,
      );
    }

    Widget content = Container(
      height: height,
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: token.background,
        borderRadius: radius,
        border: token.border != null
            ? Border(
                bottom: BorderSide(
                  color: token.border!,
                  width: GbTabGeometry.activeBorderWidth,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 📱 Mobile Fix: Graceful truncation if the text is STILL too long for the screen
          Flexible(
            child: Text(
              label,
              style: finalTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (badgeWidget != null) ...[
            const SizedBox(width: GbTabGeometry.gapTextToBadge),
            SizedBox(height: GbTabGeometry.badgeHeight, child: badgeWidget),
          ],
        ],
      ),
    );

    final interactiveWidget = InkWell(
      onTap: onTap,
      borderRadius: radius,
      child: content,
    );

    if (fullWidth) {
      return SizedBox(height: height, child: interactiveWidget);
    }

    return interactiveWidget;
  }
}
