import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../gb_input_geometry.dart';
import '../gb_input_tokens.dart';
import '../gb_input_types.dart';
import '../gb_input_state.dart';

class GbInputTrailingDropdown extends StatefulWidget {
  const GbInputTrailingDropdown({
    super.key,
    required this.size,
    required this.enabled,
    required this.destructive,
    required this.state,

    required this.leadingText, // e.g. "$"
    required this.dropdownText, // e.g. "USD"
    required this.onDropdownPressed,

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
  State<GbInputTrailingDropdown> createState() =>
      _GbInputTrailingDropdownState();
}

class _GbInputTrailingDropdownState extends State<GbInputTrailingDropdown> {
  // 🗑️ DELETED: Old Help/Error assets. Kept Dropdown Arrow.
  static const String _dropdownIconAsset = 'assets/icons/dropdown_icon.svg';

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
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1️⃣ Resolve visual intent
    final intent = GbInputStateResolver.toVisualIntent(
      state: widget.state,
      destructive: widget.destructive,
    );

    final bool effectiveEnabled =
        widget.enabled && widget.state != GbInputState.disabled;

    // 2️⃣ Geometry
    final height = GbInputGeometry.height(widget.size);
    final radius = GbInputGeometry.borderRadius(widget.size);

    // 3️⃣ Tokens
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

    // 4️⃣ The Field Container
    final fieldContainer = Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: GbInputGeometry.paddingLeft(widget.size),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Row(
        children: [
          // ─── 1. LEADING TEXT (e.g. $) ───
          Text(
            widget.leadingText,
            style: GbInputTokens.inputTextStyle(widget.size).copyWith(
              color: GbInputTokens.prefixLeadingTextColor(context, intent),
            ),
          ),

          // ─── 2. GAP (8px) ───
          const SizedBox(
            width: GbInputGeometry.trailingLeadingTextToFieldSpacing,
          ),

          // ─── 3. INPUT FIELD ───
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
                if (mounted) setState(() => _hasValue = v.isNotEmpty);
                widget.onChanged?.call(v);
              },
            ),
          ),

          // ─── 4. GAP (8px) ───
          // Keeps distance from input text, regardless of whether icon exists
          const SizedBox(width: GbInputGeometry.trailingFieldToIconSpacing),

          // ─── 5. ✅ NEW: Smart Status Icon (Replaces Old Logic) ───
          if (widget.statusIcon != null) ...[
            widget.statusIcon!,

            // ─── 6. GAP (4px) ───
            // Only show this small gap if the icon is actually present
            const SizedBox(
              width: GbInputGeometry.trailingIconToDropdownSpacing,
            ),
          ],

          // ─── 7. DROPDOWN TRIGGER (Text + Icon) ───
          GestureDetector(
            onTap: effectiveEnabled ? widget.onDropdownPressed : null,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dropdown Text (USD)
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

                // Dropdown Arrow
                SvgPicture.asset(
                  _dropdownIconAsset,
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
        ],
      ),
    );

    // 5️⃣ Final Assembly
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
