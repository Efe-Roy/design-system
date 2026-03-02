import 'package:flutter/material.dart';

import '../gb_input_geometry.dart';
import '../gb_input_tokens.dart';
import '../gb_input_types.dart';
import '../gb_input_state.dart';

class GbInputLeadingText extends StatefulWidget {
  const GbInputLeadingText({
    super.key,
    required this.size,
    required this.enabled,
    required this.destructive,
    required this.state,

    /// REQUIRED: text shown in leading segment (e.g. https://, www., ₦)
    required this.leadingText,

    this.label,
    this.placeholder,
    this.helperText,
    this.controller,
    this.focusNode,
    this.onChanged,

    // ✅ 1. Added Smart Icon Parameter
    this.statusIcon,
  });

  final GbInputSize size;
  final bool enabled;
  final bool destructive;
  final GbInputState state;

  final String leadingText;

  final String? label;
  final String? placeholder;
  final String? helperText;

  // ✅ 2. Added Smart Icon Field
  final Widget? statusIcon;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;

  @override
  State<GbInputLeadingText> createState() => _GbInputLeadingTextState();
}

class _GbInputLeadingTextState extends State<GbInputLeadingText> {
  // 🗑️ DELETED: Old hardcoded icon assets

  late final FocusNode _focusNode;
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _hasValue = widget.controller?.text.isNotEmpty ?? false;
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
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
    final borderWidth = GbInputTokens.borderWidth(intent);
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

    // ───────── LEADING TEXT SEGMENT ─────────
    final leadingSegment = Container(
      height: height,
      constraints: const BoxConstraints(
        minWidth: GbInputGeometry.leadingTextMinWidth,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        ),
        border: Border.all(color: secondaryBorderColor, width: borderWidth),
      ),
      child: Text(
        widget.leadingText,
        style: GbInputTokens.inputTextStyle(
          widget.size,
        ).copyWith(color: GbInputTokens.prefixTextColor(context, intent)),
      ),
    );

    // ───────── MAIN INPUT SEGMENT ─────────
    final mainSegment = Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: GbInputGeometry.paddingLeft(widget.size),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
        border: Border(
          top: BorderSide(color: mainBorderColor, width: borderWidth),
          right: BorderSide(color: mainBorderColor, width: borderWidth),
          bottom: BorderSide(color: mainBorderColor, width: borderWidth),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: effectiveEnabled,
              style: inputStyle,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: hintStyle,
              ),
              onChanged: (v) {
                if (mounted) {
                  setState(() => _hasValue = v.isNotEmpty);
                }
                widget.onChanged?.call(v);
              },
            ),
          ),

          // ─── ✅ NEW: Smart Status Icon (Replaces Old Logic) ───
          if (widget.statusIcon != null)
            Padding(
              padding: const EdgeInsets.only(
                left: GbInputGeometry.contentToInfoIconSpacing,
              ),
              child: widget.statusIcon!,
            ),
        ],
      ),
    );

    final divider = Container(
      height: height,
      width: dividerWidth,
      color: mainBorderColor,
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
            leadingSegment,
            divider,
            Expanded(child: mainSegment),
          ],
        ),
        if (widget.helperText != null) ...[
          const SizedBox(height: GbInputGeometry.fieldToFooterSpacing),
          Text(
            widget.helperText!,
            style: GbInputTokens.helperTextStyle().copyWith(
              color: GbInputTokens.footerTextColor(
                context,
                intent,
                destructive: widget.destructive,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
