import 'package:flutter/material.dart';
import '../gb_input_geometry.dart';
import '../gb_input_tokens.dart';
import '../gb_input_types.dart';
import '../gb_input_state.dart';
import 'package:design_system/core/common/components/gb_button/gb_button.dart';
import 'package:design_system/core/common/components/gb_button/gb_button_types.dart';

class GbInputPasswordIconLeading extends StatefulWidget {
  const GbInputPasswordIconLeading({
    super.key,
    required this.size,
    required this.enabled,
    required this.destructive,
    required this.state,
    required this.leadingIcon,
    this.label,
    this.placeholder,
    this.helperText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.statusIcon,
  });

  final GbInputSize size;
  final bool enabled;
  final bool destructive;
  final GbInputState state;
  final Widget leadingIcon;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final Widget? statusIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  @override
  State<GbInputPasswordIconLeading> createState() =>
      _GbInputPasswordIconLeadingState();
}

class _GbInputPasswordIconLeadingState
    extends State<GbInputPasswordIconLeading> {
  late final FocusNode _focusNode;
  bool _hasValue = false;
  bool _obscureText = true;

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

  void _toggleVisibility() {
    final effectiveEnabled =
        widget.enabled && widget.state != GbInputState.disabled;

    if (!effectiveEnabled) return;
    if (mounted) {
      setState(() {
        _obscureText = !_obscureText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Resolve Intent & Colors (Kept your logic)
    final intent = GbInputStateResolver.toVisualIntent(
      state: widget.state,
      destructive: widget.destructive,
    );

    final bool effectiveEnabled =
        widget.enabled && widget.state != GbInputState.disabled;

    final height = GbInputGeometry.height(widget.size);
    final radius = GbInputGeometry.borderRadius(widget.size);

    final borderColor = GbInputTokens.borderColor(
      context,
      intent,
      destructive: widget.destructive,
    );
    final borderWidth = GbInputTokens.borderWidth(intent);
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

    final fieldContainer = GestureDetector(
      onTap: () {
        if (effectiveEnabled) _focusNode.requestFocus();
      },
      child: Container(
        height: height,
        padding: EdgeInsets.only(
          left: GbInputGeometry.paddingLeft(widget.size),
          right: 8.0, // 💡 Adjusted right padding for the new button
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Row(
          children: [
            // ─── LEADING ICON (Your specific geometry) ───
            IconTheme(
              data: IconThemeData(
                size: GbInputGeometry.passwordLeadingIconSize,
                color: GbInputTokens.passwordLeadingIconColor(
                  context,
                  effectiveEnabled,
                ),
              ),
              child: widget.leadingIcon,
            ),

            const SizedBox(
              width: GbInputGeometry.passwordLeadingIconToTextSpacing,
            ),

            // ─── INPUT AREA ───
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                enabled: effectiveEnabled,
                obscureText: _obscureText,
                obscuringCharacter: '•',
                enableSuggestions: false,
                autocorrect: false,
                style: inputStyle,
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: widget.placeholder,
                  hintStyle: hintStyle,
                ),
                onChanged: (v) {
                  setState(() => _hasValue = v.isNotEmpty);
                  widget.onChanged?.call(v);
                },
              ),
            ),

            // ─── STATUS ICON (Tooltip) ───
            if (widget.statusIcon != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: GbInputGeometry.passwordContentToIconSpacing,
                ),
                child: widget.statusIcon!,
              ),

            // ─── SPACING ───
            // Kept your spacing constant
            const SizedBox(width: GbInputGeometry.passwordIconToTextSpacing),

            // ─── 🆕 BUTTON (Replaces GestureDetector) ───
            GbButton(
              label: _obscureText ? "SHOW" : "HIDE",
              hierarchy: GbButtonHierarchy.tertiaryGray,
              size: GbButtonSize.sm,
              onPressed: effectiveEnabled ? _toggleVisibility : null,
              // Note: We removed the fixed width container here so the button
              // sizes itself naturally based on its text content.
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: GbInputTokens.labelTextStyle()),
          const SizedBox(height: GbInputGeometry.labelToFieldSpacing),
        ],
        fieldContainer,
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
