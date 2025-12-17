import 'package:flutter/material.dart';
import 'package:design_system/blocs/theme/gb_semantic_tokens.dart';
import 'gb_button_files.dart';
import 'gb_button_extensions.dart';

class GbButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final GbButtonSize size;
  final GbButtonHierarchy hierarchy;
  final bool destructive;
  final GbButtonState state;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isFullWidth;

  const GbButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = GbButtonSize.md,
    this.hierarchy = GbButtonHierarchy.primary,
    this.destructive = false,
    this.state = GbButtonState.normal,
    this.leadingIcon,
    this.trailingIcon,
    this.isFullWidth = false,
  });

  @override
  State<GbButton> createState() => _GbButtonState();
}

class _GbButtonState extends State<GbButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = SemanticColors.of(context);
    final sizeConfig = resolveButtonSize(widget.size);

    final bool disabled = widget.state == GbButtonState.disabled;
    final bool loading = widget.state == GbButtonState.loading;
    final bool isLink = widget.hierarchy.isLink;

    /// Determine the effective visual state
    final GbButtonState effectiveState = disabled
        ? GbButtonState.disabled
        : _isPressed
        ? GbButtonState.pressed
        : widget.state;

    final colorConfig = resolveButtonColors(
      colors: colors,
      hierarchy: widget.hierarchy,
      destructive: widget.destructive,
      state: effectiveState,
    );

    final Widget content = loading
        ? SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(colorConfig.foreground),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leadingIcon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    size: sizeConfig.iconSize,
                    color: colorConfig.foreground,
                  ),
                  child: widget.leadingIcon!,
                ),
                SizedBox(width: sizeConfig.gap),
              ],
              Text(
                widget.label,
                style: sizeConfig.textStyle.copyWith(
                  color: colorConfig.foreground,
                ),
              ),
              if (widget.trailingIcon != null) ...[
                SizedBox(width: sizeConfig.gap),
                IconTheme(
                  data: IconThemeData(
                    size: sizeConfig.iconSize,
                    color: colorConfig.foreground,
                  ),
                  child: widget.trailingIcon!,
                ),
              ],
            ],
          );

    final Widget button = Material(
      color: colorConfig.background,
      borderRadius: widget.hierarchy.borderRadius,
      child: InkWell(
        onTap: disabled || loading ? null : widget.onPressed,
        onTapDown: (_) {
          if (!disabled && !loading) {
            setState(() => _isPressed = true);
          }
        },
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),

        // 👇 DISABLE RIPPLE & HIGHLIGHT
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,

        borderRadius: widget.hierarchy.borderRadius,
        child: Container(
          height: isLink ? null : sizeConfig.height,
          padding: isLink ? EdgeInsets.zero : sizeConfig.padding,
          decoration: BoxDecoration(
            borderRadius: widget.hierarchy.borderRadius,
            border: colorConfig.border != null
                ? Border.all(color: colorConfig.border!, width: 1)
                : null,
          ),

          alignment: Alignment.center,
          child: content,
        ),
      ),
    );

    return widget.isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : UnconstrainedBox(
            alignment: Alignment.centerLeft,
            constrainedAxis: Axis.vertical,
            child: button,
          );
  }
}
