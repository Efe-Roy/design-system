import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'gb_input_types.dart';
import 'gb_input_state.dart';
import 'gb_input_geometry.dart';
import 'gb_input_tokens.dart';
import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';
import 'components/gb_input_icon_leading.dart';
import 'components/gb_input_leading_dropdown.dart';
import 'components/gb_input_password.dart';
import 'components/gb_input_password_icon_leading.dart';
import 'components/gb_input_payment.dart';
import 'components/gb_input_leading_text.dart';
import 'components/gb_input_count.dart';
import 'components/gb_input_trailing_button.dart';
import 'components/gb_input_trailing_dropdown.dart';
import 'components/gb_input_tags.dart';
import 'package:design_system/core/common/components/gb_tooltip/gb_tooltip.dart';

class GbInputField extends StatefulWidget {
  const GbInputField({
    super.key,
    required this.size,
    required this.type,
    this.state = GbInputState.normal,
    this.leadingText,
    this.label,
    this.placeholder,
    this.hintText,
    this.errorText,
    this.validator,
    this.tooltip,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.destructive = false,
    this.trailing,
    this.onChanged,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.leadingIcon,
    this.dropdownText,
    this.onDropdownPressed,
    this.tags,
    this.onTagDeleted,
    this.onFieldSubmitted,
    this.suggestionsCallback,
    this.onSuggestionSelected,
    this.onIncrement,
    this.onDecrement,
  });

  final GbInputSize size;
  final GbInputType type;
  final GbInputState? state;
  final String? label;
  final String? leadingText;
  final String? placeholder;
  final String? hintText;
  final String? errorText;
  final String? tooltip;
  final String? Function(String? value)? validator;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool enabled;
  final bool destructive;
  final Widget? trailing;
  final ValueChanged<String>? onChanged;
  final Widget? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  final Widget? leadingIcon;
  final String? dropdownText;
  final VoidCallback? onDropdownPressed;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final List<GbTagData>? tags;
  final ValueChanged<GbTagData>? onTagDeleted;
  final ValueChanged<String>? onFieldSubmitted;
  final Future<List<GbTagData>> Function(String)? suggestionsCallback;
  final ValueChanged<GbTagData>? onSuggestionSelected;

  @override
  State<GbInputField> createState() => _GbInputFieldState();
}

class _GbInputFieldState extends State<GbInputField> {
  static const String _helpIconAsset = 'assets/icons/help.svg';
  static const String _errorIconAsset = 'assets/icons/error.svg';

  late final FocusNode _focusNode;
  bool _hasValue = false;
  String? _validationError;

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

  void _handleChanged(String value) {
    setState(() {
      _hasValue = value.isNotEmpty;
      if (widget.validator != null) {
        _validationError = widget.validator!(value);
      } else {
        _validationError = null;
      }
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    //  Calculate Helper Text
    final String? effectiveHelperText =
        _validationError ?? widget.errorText ?? widget.hintText;

    //  Calculate Destructive State
    final bool effectiveDestructive =
        _validationError != null ||
        widget.errorText != null ||
        widget.destructive;

    //  Calculate Tooltip Message
    final String? effectiveTooltipMessage = effectiveDestructive
        ? effectiveHelperText
        : widget.tooltip;

    GbInputState designState;
    if (!widget.enabled || widget.state == GbInputState.disabled) {
      designState = GbInputState.disabled;
    } else if (_focusNode.hasFocus) {
      designState = GbInputState.active;
    } else if (widget.state != null) {
      designState = widget.state!;
    } else {
      designState = _hasValue ? GbInputState.filled : GbInputState.normal;
    }

    //  (Needed for Icon Color)
    final intent = GbInputStateResolver.toVisualIntent(
      state: designState,
      destructive: effectiveDestructive,
    );

    Widget? smartStatusIcon;

    if (effectiveDestructive) {
      // 🔴 ERROR
      smartStatusIcon = _TooltipIcon(
        message: effectiveTooltipMessage,
        isError: true,
        child: _SvgIcon(
          assetPath: _errorIconAsset,
          size: GbInputGeometry.errorIconSize,
          color: GbInputTokens.errorIconColor(context),
        ),
      );
    } else if (widget.tooltip != null) {
      // ℹ️ HELP (Only if tooltip exists)
      smartStatusIcon = _TooltipIcon(
        message: widget.tooltip,
        isError: false,
        child: _SvgIcon(
          assetPath: _helpIconAsset,
          size: GbInputGeometry.helpIconSize,
          color: GbInputTokens.helpIconColor(context, intent),
        ),
      );
    }

    // ─────────────────────────────────────────────
    // 6️⃣ Delegate specialized inputs
    //
    // ─────────────────────────────────────────────

    if (widget.type == GbInputType.leadingText) {
      return GbInputLeadingText(
        size: widget.size,
        state: designState,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        leadingText: widget.leadingText ?? '',
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.count) {
      return GbInputCount(
        size: widget.size,
        state: designState,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        onIncrement: widget.onIncrement,
        onDecrement: widget.onDecrement,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.trailingButton) {
      return GbInputTrailingButton(
        size: widget.size,
        state: designState,
        destructive: effectiveDestructive,
        trailingIcon: widget.trailingIcon ?? const SizedBox(),
        onTrailingIconPressed: widget.onTrailingIconPressed,
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.password) {
      return GbInputPassword(
        size: widget.size,
        state: designState,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.passwordIconLeading) {
      return GbInputPasswordIconLeading(
        size: widget.size,
        state: designState,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        leadingIcon: widget.leadingIcon ?? const SizedBox(),
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.iconLeading) {
      return GbInputIconLeading(
        size: widget.size,
        state: designState,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        leadingIcon: widget.leadingIcon ?? const SizedBox(),
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.leadingDropdown) {
      return GbInputLeadingDropdown(
        size: widget.size,
        state: designState,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        leadingIcon: widget.leadingIcon ?? const SizedBox(),
        dropdownText: widget.dropdownText ?? '',
        onDropdownPressed: widget.onDropdownPressed,
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.paymentInput) {
      return GbInputPayment(
        size: widget.size,
        state: designState,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        leadingIcon: widget.leadingIcon ?? const SizedBox(),
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.trailingDropdown) {
      return GbInputTrailingDropdown(
        size: widget.size,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        state: designState,
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        leadingText: widget.leadingText ?? '',
        dropdownText: widget.dropdownText ?? '',
        onDropdownPressed: widget.onDropdownPressed,
        statusIcon: smartStatusIcon,
      );
    }

    if (widget.type == GbInputType.tags) {
      return GbInputTags(
        size: widget.size,
        enabled: widget.enabled,
        destructive: effectiveDestructive,
        state: designState,
        label: widget.label,
        placeholder: widget.placeholder,
        helperText: effectiveHelperText,
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: _handleChanged,
        tags: widget.tags ?? [],
        onTagDeleted: widget.onTagDeleted ?? (_) {},
        onFieldSubmitted: widget.onFieldSubmitted,
        suggestionsCallback: widget.suggestionsCallback,
        onSuggestionSelected: widget.onSuggestionSelected,
        statusIcon: smartStatusIcon,
      );
    }

    // ─────────────────────────────────────────────
    // Fallback Logic
    // ─────────────────────────────────────────────

    // We already resolved 'intent' above, so we reuse it here
    final bool effectiveEnabled =
        widget.enabled && designState != GbInputState.disabled;
    final height = GbInputGeometry.height(widget.size);
    final radius = GbInputGeometry.borderRadius(widget.size);
    final borderColor = GbInputTokens.borderColor(
      context,
      intent,
      destructive: effectiveDestructive,
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
                hintText: widget.placeholder,
                hintStyle: hintStyle,
              ),
              onChanged: _handleChanged,
            ),
          ),

          if (smartStatusIcon != null)
            Padding(
              padding: const EdgeInsets.only(
                left: GbInputGeometry.contentToInfoIconSpacing,
              ),
              child: smartStatusIcon,
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
        if (effectiveHelperText != null) ...[
          const SizedBox(height: GbInputGeometry.fieldToFooterSpacing),
          Text(
            effectiveHelperText,
            style: GbInputTokens.helperTextStyle().copyWith(
              color: GbInputTokens.footerTextColor(
                context,
                intent,
                destructive: effectiveDestructive,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 🆕 HYBRID TOOLTIP ICON
// Error -> Native Red Tooltip
// Info -> Custom GbTooltip
// ─────────────────────────────────────────────
class _TooltipIcon extends StatefulWidget {
  const _TooltipIcon({
    required this.message,
    required this.isError,
    required this.child,
  });

  final String? message;
  final bool isError;
  final Widget child;

  @override
  State<_TooltipIcon> createState() => _TooltipIconState();
}

class _TooltipIconState extends State<_TooltipIcon> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleTooltip() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
  }

  void _showOverlay() {
    if (widget.message == null || widget.message!.isEmpty) return;

    final overlay = Overlay.of(context);
    final theme = Theme.of(context);
    final renderBox = context.findRenderObject() as RenderBox;

    // 🧠 1. Calculate Screen Position
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenWidth = MediaQuery.of(context).size.width;
    final iconCenterX = offset.dx + (renderBox.size.width / 2);

    // 🧠 2. Determine Position Logic
    // If icon is in the rightmost 25% of the screen -> Align Right
    // If icon is in the leftmost 25% of the screen -> Align Left
    // Otherwise -> Align Center

    Alignment targetAnchor;
    Alignment followerAnchor;
    Arrow arrowStyle;
    Offset positionOffset;

    if (iconCenterX > screenWidth * 0.75) {
      // ➡️ RIGHT EDGE CASE
      // Align Tooltip Right to Icon Right
      targetAnchor = Alignment.topRight;
      followerAnchor = Alignment.bottomRight;
      arrowStyle = Arrow.bottomRight;
      // Shift right slightly so arrow centers on the small icon
      positionOffset = const Offset(28, 3);
    } else if (iconCenterX < screenWidth * 0.25) {
      // ⬅️ LEFT EDGE CASE
      // Align Tooltip Left to Icon Left
      targetAnchor = Alignment.topLeft;
      followerAnchor = Alignment.bottomLeft;
      arrowStyle = Arrow.bottomLeft;
      // Shift left slightly so arrow centers on the small icon
      positionOffset = const Offset(-28, 3);
    } else {
      // ⏺️ CENTER CASE
      targetAnchor = Alignment.topCenter;
      followerAnchor = Alignment.bottomCenter;
      arrowStyle = Arrow.bottomCenter;
      positionOffset = const Offset(0, 3);
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: targetAnchor,
              followerAnchor: followerAnchor,
              offset: positionOffset,

              child: Theme(
                data: theme,
                child: Material(
                  color: Colors.transparent,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: GbTooltip(label: widget.message!, arrow: arrowStyle),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  @override
  Widget build(BuildContext context) {
    // 🔴 CASE 1: ERROR STATE (Use OLD Native Tooltip)
    if (widget.isError) {
      final colors = SemanticColors.of(context);
      return Tooltip(
        message: widget.message ?? '',
        triggerMode: TooltipTriggerMode.tap,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        verticalOffset: 12,
        preferBelow: false, // Shows above by default
        decoration: BoxDecoration(
          color: colors.backgroundBrandRedHover, // 🔴 Red Background
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: colors.textInverse, // White text
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        child: widget.child,
      );
    }

    // 🔵 CASE 2: INFO STATE (Use NEW Custom Overlay)
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(onTap: _toggleTooltip, child: widget.child),
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
