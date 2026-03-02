import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gb_input_geometry.dart';
import '../gb_input_tokens.dart';
import '../gb_input_types.dart';
import '../gb_input_state.dart';

class GbInputIconLeading extends StatefulWidget {
  const GbInputIconLeading({
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

    // ✅ 1. Added Smart Icon Parameter
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

  // ✅ 2. Added Smart Icon Field
  final Widget? statusIcon;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;

  @override
  State<GbInputIconLeading> createState() => _GbInputIconLeadingState();
}

class _GbInputIconLeadingState extends State<GbInputIconLeading> {
  // 🗑️ DELETED: Old Help/Error assets. Kept Clear Icon.
  static const String _closeIconAsset = 'assets/icons/clear.svg';

  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);

    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChange);

    _hasValue = _controller.text.isNotEmpty;
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleTextChange() {
    if (!mounted) return;
    final hasVal = _controller.text.isNotEmpty;
    if (hasVal != _hasValue) {
      setState(() => _hasValue = hasVal);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_handleTextChange);
    if (widget.focusNode == null) _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onClearPressed() {
    if (!widget.enabled || widget.state == GbInputState.disabled) return;
    _controller.clear();
    widget.onChanged?.call('');
    if (mounted) {
      setState(() => _hasValue = false);
    }
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

    final fieldContainer = GestureDetector(
      onTap: () {
        if (effectiveEnabled) _focusNode.requestFocus();
      },
      child: Container(
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
            // ─── LEADING ICON ───
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

            // ─── Input Area ───
            Expanded(
              child: TextField(
                controller: _controller,
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
                  widget.onChanged?.call(v);
                },
              ),
            ),

            // ─── TRAILING SECTION ───
            const SizedBox(width: GbInputGeometry.textToTrailingIconSpacing),

            // 1. Smart Status Icon (Help/Error)
            if (widget.statusIcon != null)
              widget
                  .statusIcon!, // Just the icon, spacing handled below or via Row logic
            // 2. Clear "X" Button (Only if text exists)
            if (_hasValue && !widget.destructive) ...[
              // Only show clear button if NOT destructive (usually error state hides clear or keeps it, depends on UX.
              // Based on your previous code, destructive state HID the clear button. I will preserve that behavior.)

              // If we have a status icon, add spacing between it and the clear button
              if (widget.statusIcon != null)
                const SizedBox(width: GbInputGeometry.helpToClearButtonSpacing),

              GestureDetector(
                onTap: _onClearPressed,
                behavior: HitTestBehavior.opaque,
                child: SvgPicture.asset(
                  _closeIconAsset,
                  width: GbInputGeometry.clearButtonSize,
                  height: GbInputGeometry.clearButtonSize,
                  colorFilter: ColorFilter.mode(
                    GbInputTokens.clearButtonColor(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],

            // Right padding so icons aren't glued to the edge
            const SizedBox(width: GbInputGeometry.contentToInfoIconSpacing),
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
