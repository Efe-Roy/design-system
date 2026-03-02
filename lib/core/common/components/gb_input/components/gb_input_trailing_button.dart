import 'package:flutter/material.dart';

import '../gb_input_geometry.dart';
import '../gb_input_tokens.dart';
import '../gb_input_state.dart';
import '../gb_input_types.dart';

class GbInputTrailingButton extends StatefulWidget {
  const GbInputTrailingButton({
    super.key,
    required this.size,
    required this.state,
    required this.destructive,
    required this.trailingIcon,
    required this.onTrailingIconPressed,
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
  final GbInputState state;
  final bool destructive;

  /// Icon provided by API (SVG, Icon, etc.)
  final Widget trailingIcon;
  final VoidCallback? onTrailingIconPressed;

  final String? label;
  final String? placeholder;
  final String? helperText;

  // ✅ 2. Added Smart Icon Field
  final Widget? statusIcon;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;

  @override
  State<GbInputTrailingButton> createState() => _GbInputTrailingButtonState();
}

class _GbInputTrailingButtonState extends State<GbInputTrailingButton> {
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
    // 1️⃣ Resolve visual intent
    final intent = GbInputStateResolver.toVisualIntent(
      state: widget.state,
      destructive: widget.destructive,
    );

    final bool isDisabled = widget.state == GbInputState.disabled;

    // 2️⃣ Geometry
    final height = GbInputGeometry.height(widget.size);
    final radius = GbInputGeometry.borderRadius(widget.size);

    final trailingContainerSize = GbInputGeometry.trailingIconContainerSize(
      widget.size,
    );
    final trailingSpacing = GbInputGeometry.trailingIconSpacing(widget.size);

    // 3️⃣ Tokens
    final borderColor = GbInputTokens.borderColor(
      context,
      intent,
      destructive: widget.destructive,
    );
    final borderWidth = GbInputTokens.borderWidth(intent);
    final backgroundColor = GbInputTokens.backgroundColor(context, intent);
    final textColor = GbInputTokens.inputTextColor(
      context,
      enabled: !isDisabled,
      isnormal: !_hasValue,
    );
    final trailingIconColor = GbInputTokens.trailingIconColor(context, intent);
    final trailingIconBackground = GbInputTokens.trailingIconBackgroundColor(
      context,
      intent,
    );

    // 4️⃣ Field (UPDATED WITH GESTURE DETECTOR)
    final field = GestureDetector(
      // 👇 This ensures tapping anywhere in the box triggers focus
      onTap: () {
        if (!isDisabled) {
          _focusNode.requestFocus();
        }
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: GbInputGeometry.paddingLeft(widget.size),
        ),
        child: Row(
          children: [
            // ───── Text field ─────
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                enabled: !isDisabled,
                style: GbInputTokens.inputTextStyle(
                  widget.size,
                ).copyWith(color: textColor),
                decoration: InputDecoration(
                  isCollapsed: true, // 👈 Makes wrapper essential
                  border: InputBorder.none,
                  hintText: widget.placeholder,
                  hintStyle: GbInputTokens.inputTextStyle(
                    widget.size,
                  ).copyWith(color: textColor),
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

            // ───── Spacing ─────
            SizedBox(width: trailingSpacing),

            // ───── Trailing icon button ─────
            GestureDetector(
              onTap: isDisabled ? null : widget.onTrailingIconPressed,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: trailingContainerSize,
                height: trailingContainerSize,
                decoration: BoxDecoration(
                  color: trailingIconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: IconTheme(
                  data: IconThemeData(
                    size: GbInputGeometry.trailingIconSize,
                    color: trailingIconColor,
                  ),
                  child: widget.trailingIcon,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // 5️⃣ Layout
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: GbInputTokens.labelTextStyle()),
          const SizedBox(height: GbInputGeometry.labelToFieldSpacing),
        ],
        field,
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
