import 'package:flutter/material.dart';
import 'package:design_system/core/common/components/gb_button/gb_button.dart';
import 'package:design_system/core/common/components/gb_button/gb_button_types.dart';
import 'package:design_system/core/common/components/gb_input/gb_input_geometry.dart';
import 'package:design_system/core/common/components/gb_input/gb_input_tokens.dart';
import 'package:design_system/core/common/components/gb_input/gb_input_types.dart';
import 'package:design_system/core/common/components/gb_input/gb_input_state.dart';

class GbInputPassword extends StatefulWidget {
  const GbInputPassword({
    super.key,
    required this.size,
    required this.state,
    required this.enabled,
    required this.destructive,
    this.label,
    this.placeholder,
    this.helperText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.statusIcon,
  });

  final GbInputSize size;
  final GbInputState state;
  final bool enabled;
  final bool destructive;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final Widget? statusIcon;

  @override
  State<GbInputPassword> createState() => _GbInputPasswordState();
}

class _GbInputPasswordState extends State<GbInputPassword> {
  bool _obscureText = true; // Default: Hidden

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Resolve Intent & Colors (Same as Master Input)
    final intent = GbInputStateResolver.toVisualIntent(
      state: widget.state,
      destructive: widget.destructive,
    );
    final effectiveEnabled =
        widget.enabled && widget.state != GbInputState.disabled;

    final borderColor = GbInputTokens.borderColor(
      context,
      intent,
      destructive: widget.destructive,
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
        isnormal: true,
      ),
    );

    // 2. Build the Field Container
    final field = Container(
      height: GbInputGeometry.height(widget.size),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          GbInputGeometry.borderRadius(widget.size),
        ),
        border: Border.all(
          color: borderColor,
          width: GbInputTokens.borderWidth(intent),
        ),
      ),
      padding: EdgeInsets.only(
        left: GbInputGeometry.paddingLeft(widget.size),
        right: 8.0, // 💡 Slight padding on right for the button
      ),
      child: Row(
        children: [
          // 🔡 Input Area
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              enabled: effectiveEnabled,
              obscureText: _obscureText, // 🔒 Toggles here
              style: inputStyle,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: hintStyle,
              ),
              onChanged: widget.onChanged,
            ),
          ),

          // ℹ️ Help/Error Icon (Tooltip)
          if (widget.statusIcon != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: widget.statusIcon!,
            ),

          // 🔘 SHOW/HIDE Button (Using GbButton)
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ), // Space between text/icon and button
            child: GbButton(
              label: _obscureText ? "SHOW" : "HIDE",
              hierarchy: GbButtonHierarchy.tertiaryGray, // 👈 As per Figma
              size: GbButtonSize.sm, // 👈 As per Figma
              onPressed: effectiveEnabled ? _toggleVisibility : null,
            ),
          ),
        ],
      ),
    );

    // 3. Assemble with Label & Helper Text
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
