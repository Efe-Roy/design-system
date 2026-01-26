import 'package:flutter/material.dart';

import 'gb_input_geometry.dart';
import 'gb_input_tokens.dart';
import 'gb_input_types.dart';
import 'gb_input_state.dart';

class GbInputCount extends StatefulWidget {
  const GbInputCount({
    super.key,
    required this.size,
    required this.enabled,
    required this.destructive,
    required this.state,

    this.label,
    this.hintText,
    this.helperText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onIncrement,
    this.onDecrement,
  });

  final GbInputSize size;
  final bool enabled;
  final bool destructive;
  final GbInputState state;

  final String? label;
  final String? hintText;
  final String? helperText;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  State<GbInputCount> createState() => _GbInputCountState();
}

class _GbInputCountState extends State<GbInputCount> {
  static const String _helpIconAsset = 'assets/icons/help.svg';
  static const String _errorIconAsset = 'assets/icons/error.svg';

  late final FocusNode _focusNode;
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => setState(() {}));
    _hasValue = widget.controller?.text.isNotEmpty ?? false;
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleInc() {
    final effectiveEnabled =
        widget.enabled && widget.state != GbInputState.disabled;
    if (!effectiveEnabled) return;

    if (widget.onIncrement != null) {
      widget.onIncrement!.call();
      return;
    }

    final c = widget.controller;
    if (c == null) return;

    final current = int.tryParse(c.text.trim()) ?? 0;
    final next = current + 1;

    c.text = '$next';
    c.selection = TextSelection.collapsed(offset: c.text.length);
    widget.onChanged?.call(c.text);
    setState(() => _hasValue = true);
  }

  void _handleDec() {
    final effectiveEnabled =
        widget.enabled && widget.state != GbInputState.disabled;
    if (!effectiveEnabled) return;

    if (widget.onDecrement != null) {
      widget.onDecrement!.call();
      return;
    }

    final c = widget.controller;
    if (c == null) return;

    final current = int.tryParse(c.text.trim()) ?? 0;
    final next = current - 1;

    c.text = '$next';
    c.selection = TextSelection.collapsed(offset: c.text.length);
    widget.onChanged?.call(c.text);
    setState(() => _hasValue = true);
  }

  @override
  Widget build(BuildContext context) {
    final intent = GbInputStateResolver.toVisualIntent(
      state: widget.state,
      destructive: widget.destructive,
    );

    final bool effectiveEnabled =
        widget.enabled && widget.state != GbInputState.disabled;

    final height = GbInputGeometry.height(widget.size);
    final radius = GbInputGeometry.borderRadius(widget.size);
    final dividerWidth = GbInputGeometry.segmentDividerWidth;

    final mainBorderColor = GbInputTokens.segmentedMainBorderColor(
      context,
      intent,
      destructive: widget.destructive,
    );

    final secondaryBorderColor = GbInputTokens.segmentedSecondaryBorderColor(
      context,
      intent,
    );

    final backgroundColor = GbInputTokens.backgroundColor(context, intent);

    final borderWidth = GbInputTokens.borderWidth(intent);

    final inputStyle = GbInputTokens.inputTextStyle(widget.size).copyWith(
      color: GbInputTokens.inputTextColor(
        context,
        enabled: effectiveEnabled,

        isnormal: false,
      ),
    );

    final hintStyle = GbInputTokens.inputTextStyle(widget.size).copyWith(
      color: GbInputTokens.inputTextColor(
        context,
        enabled: effectiveEnabled,

        isnormal: !_hasValue,
      ),
    );

    final buttonIconColor = GbInputTokens.countButtonIconColor(context, intent);

    // ───────── MAIN SEGMENT ─────────
    final mainSegment = Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: GbInputGeometry.paddingLeft(widget.size),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        ),
        border: Border(
          left: BorderSide(color: mainBorderColor, width: borderWidth),
          top: BorderSide(color: mainBorderColor, width: borderWidth),
          bottom: BorderSide(color: mainBorderColor, width: borderWidth),
          right: BorderSide(color: mainBorderColor, width: dividerWidth),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: effectiveEnabled,
              keyboardType: TextInputType.number,
              style: inputStyle,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: hintStyle,
              ),
              onChanged: (v) {
                setState(() => _hasValue = v.isNotEmpty);
                widget.onChanged?.call(v);
              },
            ),
          ),

          GbInputTokens.svgIcon(
            assetPath: widget.destructive ? _errorIconAsset : _helpIconAsset,
            size: GbInputGeometry.helpIconSize,
            color: widget.destructive
                ? GbInputTokens.errorIconColor(context)
                : GbInputTokens.helpIconColor(context, intent),
          ),
        ],
      ),
    );

    // ───────── SECONDARY SEGMENT ─────────
    final secondarySegment = Container(
      height: height,
      width: GbInputGeometry.countButtonWidth * 2,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
        border: Border(
          top: BorderSide(color: secondaryBorderColor, width: borderWidth),
          right: BorderSide(color: secondaryBorderColor, width: borderWidth),
          bottom: BorderSide(color: secondaryBorderColor, width: borderWidth),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _CountButton(
              enabled: effectiveEnabled,
              icon: Icons.remove,
              iconColor: buttonIconColor,
              onTap: _handleDec,
              showRightDivider: true,
              dividerColor: secondaryBorderColor,
              dividerWidth: dividerWidth,
            ),
          ),
          Expanded(
            child: _CountButton(
              enabled: effectiveEnabled,
              icon: Icons.add,
              iconColor: buttonIconColor,
              onTap: _handleInc,
              showRightDivider: false,
              dividerColor: secondaryBorderColor,
              dividerWidth: dividerWidth,
            ),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: GbInputTokens.labelTextStyle()),
          const SizedBox(height: GbInputGeometry.labelToFieldSpacing),
        ],
        Row(
          children: [
            Expanded(child: mainSegment),
            secondarySegment,
          ],
        ),
        if (widget.helperText != null) ...[
          const SizedBox(height: GbInputGeometry.fieldToFooterSpacing),
          Text(
            widget.helperText!,
            style: GbInputTokens.helperTextStyle().copyWith(
              color: GbInputTokens.footerTextColor(context, intent),
            ),
          ),
        ],
      ],
    );
  }
}

class _CountButton extends StatelessWidget {
  const _CountButton({
    required this.enabled,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.showRightDivider,
    required this.dividerColor,
    required this.dividerWidth,
  });

  final bool enabled;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  final bool showRightDivider;
  final Color dividerColor;
  final double dividerWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: showRightDivider
              ? Border(
                  right: BorderSide(color: dividerColor, width: dividerWidth),
                )
              : null,
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
    );
  }
}
