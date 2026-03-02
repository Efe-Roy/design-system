import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../gb_input_geometry.dart';
import '../gb_input_tokens.dart';
import '../gb_input_types.dart';
import '../gb_input_state.dart';

class GbInputLeadingDropdown extends StatefulWidget {
  const GbInputLeadingDropdown({
    super.key,
    required this.size,
    required this.enabled,
    required this.destructive,
    required this.state,
    required this.leadingIcon, // The Flag/Icon
    required this.dropdownText, // The text (e.g. "+234")
    required this.onDropdownPressed, // The callback
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

  final Widget leadingIcon;
  final String dropdownText;
  final VoidCallback? onDropdownPressed;

  final String? label;
  final String? placeholder;
  final String? helperText;

  // ✅ 2. Added Smart Icon Field
  final Widget? statusIcon;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;

  @override
  State<GbInputLeadingDropdown> createState() => _GbInputLeadingDropdownState();
}

class _GbInputLeadingDropdownState extends State<GbInputLeadingDropdown> {
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

    final fieldContainer = Container(
      height: height,
      padding: EdgeInsets.only(
        left: GbInputGeometry.paddingLeft(widget.size),
        right: 0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Row(
        children: [
          // ─────────────────────────────────────────────
          // THE DROPDOWN "TRIGGER" ZONE
          // ─────────────────────────────────────────────
          GestureDetector(
            onTap: effectiveEnabled ? widget.onDropdownPressed : null,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Leading Icon (Flag) - 24px
                SizedBox(
                  width: GbInputGeometry.dropdownLeadingIconSize,
                  height: GbInputGeometry.dropdownLeadingIconSize,
                  child: widget.leadingIcon,
                ),

                const SizedBox(
                  width: GbInputGeometry.dropdownIconToTextSpacing,
                ),

                // 2. Dropdown Text (+234)
                Text(
                  widget.dropdownText,
                  style: GbInputTokens.dropdownTextStyle(widget.size).copyWith(
                    color: GbInputTokens.dropdownTextColor(
                      context,
                      effectiveEnabled,
                    ),
                  ),
                ),

                const SizedBox(
                  width: GbInputGeometry.dropdownTextToArrowSpacing,
                ),

                // 3. Arrow Icon - 20px
                SvgPicture.asset(
                  'assets/icons/dropdown_icon.svg',
                  width: GbInputGeometry.dropdownArrowWidth,
                  height: GbInputGeometry.dropdownArrowHeight,
                  colorFilter: ColorFilter.mode(
                    GbInputTokens.dropdownArrowColor(context, effectiveEnabled),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),

          // ─── SPACING BEFORE FIELD (16px) ───
          const SizedBox(width: GbInputGeometry.dropdownArrowToFieldSpacing),

          // ─────────────────────────────────────────────
          // THE INPUT FIELD
          // ─────────────────────────────────────────────
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
                right: GbInputGeometry
                    .contentToInfoIconSpacing, // Symmetric padding for balance
              ),
              child: widget.statusIcon!,
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
