import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gb_input_types.dart';
import 'gb_input_state.dart';
import 'gb_input_geometry.dart';
import 'gb_input_tokens.dart';
import 'gb_input_leading_text.dart';
import 'gb_input_count.dart';
import 'gb_input_trailing_button.dart';
//import 'package:design_system/core/common/components/gb_button/gb_button.dart';

class GbInputField extends StatefulWidget {
  const GbInputField({
    super.key,
    required this.size,
    required this.kind,

    /// Optional: force a design state (DesignSystemPage only)
    this.state,
    this.leadingText,
    this.label,
    this.hintText,
    this.helperText,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.destructive = false,
    this.trailing,
    this.onChanged,
    this.trailingIcon,
    this.onTrailingIconPressed,
  });

  final GbInputSize size;
  final GbInputType kind;

  /// PUBLIC design-facing state override
  final GbInputState? state;

  final String? label;
  final String? hintText;
  final String? helperText;
  final String? leadingText;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final bool enabled;
  final bool destructive;

  final Widget? trailing;
  final ValueChanged<String>? onChanged;

  final Widget? trailingIcon;
  final VoidCallback? onTrailingIconPressed;

  @override
  State<GbInputField> createState() => _GbInputFieldState();
}

class _GbInputFieldState extends State<GbInputField> {
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
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ─────────────────────────────────────────────
    // 1️⃣ Resolve DESIGN state (public)
    // ─────────────────────────────────────────────
    final GbInputState designState =
        widget.state ??
        GbInputStateResolver.resolveDesignState(
          enabled: widget.enabled,
          focused: _focusNode.hasFocus,
          hasValue: _hasValue,
        );

    // ─────────────────────────────────────────────
    // 2️⃣ Delegate specialized inputs
    // ─────────────────────────────────────────────
    if (widget.kind == GbInputType.leadingText) {
      return GbInputLeadingText(
        size: widget.size,
        state: designState,
        enabled: widget.enabled,
        destructive: widget.destructive,
        leadingText: widget.leadingText ?? '',
        label: widget.label,
        hintText: widget.hintText,
        helperText: widget.helperText,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
      );
    }

    if (widget.kind == GbInputType.count) {
      return GbInputCount(
        size: widget.size,
        state: designState, // ✅ ADD THIS
        enabled: widget.enabled,
        destructive: widget.destructive,
        label: widget.label,
        hintText: widget.hintText,
        helperText: widget.helperText,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
      );
    }

    // ─────────────────────────────────────────────
    // TRAILING BUTTON INPUT
    // ─────────────────────────────────────────────
    if (widget.kind == GbInputType.trailingButton) {
      assert(
        widget.trailingIcon != null,
        'trailingIcon must be provided for trailingButton input',
      );

      return GbInputTrailingButton(
        size: widget.size,
        state: designState,
        destructive: widget.destructive, // ✅ REQUIRED
        trailingIcon: widget.trailingIcon!,
        onTrailingIconPressed: widget.onTrailingIconPressed,
        label: widget.label,
        hintText: widget.hintText,
        helperText: widget.helperText,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
      );
    }

    // ─────────────────────────────────────────────
    // 3️⃣ Map design state → visual intent (tokens)
    // ─────────────────────────────────────────────
    final intent = GbInputStateResolver.toVisualIntent(
      state: designState,
      destructive: widget.destructive,
    );

    final bool effectiveEnabled =
        widget.enabled && designState != GbInputState.disabled;

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
        isnormal: true,
      ),
    );

    // ─────────────────────────────────────────────
    // 4️⃣ Base text input field
    // ─────────────────────────────────────────────
    final field = Container(
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
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: effectiveEnabled,
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

          // Help icon (non-destructive)
          if (!widget.destructive)
            Padding(
              padding: const EdgeInsets.only(
                left: GbInputGeometry.contentToInfoIconSpacing,
              ),
              child: _SvgIcon(
                assetPath: _helpIconAsset,
                size: GbInputGeometry.helpIconSize,
                color: GbInputTokens.helpIconColor(context, intent),
              ),
            ),

          // Error icon (destructive)
          if (widget.destructive)
            Padding(
              padding: const EdgeInsets.only(
                left: GbInputGeometry.contentToInfoIconSpacing,
              ),
              child: _SvgIcon(
                assetPath: _errorIconAsset,
                size: GbInputGeometry.errorIconSize,
                color: GbInputTokens.errorIconColor(context),
              ),
            ),

          if (widget.trailing != null)
            Padding(
              padding: EdgeInsets.only(
                left: GbInputGeometry.infoIconToTrailingSpacing(widget.size),
              ),
              child: widget.trailing!,
            ),
        ],
      ),
    );

    // ─────────────────────────────────────────────
    // 5️⃣ Final layout
    // ─────────────────────────────────────────────
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: GbInputTokens.labelTextStyle().copyWith(
              color: GbInputTokens.labelTextColor(context),
            ),
          ),
          const SizedBox(height: GbInputGeometry.labelToFieldSpacing),
        ],
        field,
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

class _SvgIcon extends StatelessWidget {
  const _SvgIcon({
    required this.assetPath,
    required this.size,
    required this.color,
  });

  final String assetPath;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
