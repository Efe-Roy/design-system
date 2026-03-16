import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gb_token_field_types.dart';
import 'gb_token_field_geometry.dart';
import 'gb_token_field_tokens.dart';

class GbTokenField extends StatefulWidget {
  const GbTokenField({
    super.key,
    this.variant = GbTokenFieldVariant.compressed,
    this.size = GbTokenFieldSize.md,
    required this.digits,
    this.label,
    this.hintText,
    this.enabled = true,
    this.alignment = MainAxisAlignment.start,
    this.tokenVisible =
        true, //  Defaults to true. Set to false for PIN/Password mode.
    this.onChanged,
    this.onCompleted,
  }) : assert(
         (variant == GbTokenFieldVariant.compressed &&
                 (digits == 4 || digits == 6)) ||
             (variant == GbTokenFieldVariant.compact &&
                 (digits == 4 || digits == 6 || digits == 8)),
         'Compressed variant only accepts 4 or 6 digits. Compact variant accepts 4, 6, or 8 digits.',
       );

  final GbTokenFieldVariant variant;
  final GbTokenFieldSize size;
  final int digits;
  final String? label;
  final String? hintText;
  final bool enabled;
  final MainAxisAlignment alignment;
  final bool tokenVisible;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<GbTokenField> createState() => _GbTokenFieldState();
}

class _GbTokenFieldState extends State<GbTokenField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(() {
      if (mounted) setState(() {});
      if (widget.onChanged != null) widget.onChanged!(_controller.text);

      if (_controller.text.length == widget.digits) {
        if (widget.onCompleted != null) {
          widget.onCompleted!(_controller.text);
        }
        _focusNode.unfocus();
      }
    });

    _focusNode.addListener(() {
      if (mounted) setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildTokenSlot(int index, double dynamicBoxSize) {
    final String currentText = _controller.text;
    final bool isFilled = index < currentText.length;

    final bool isFieldFull = currentText.length == widget.digits;
    final int activeIndex = isFieldFull
        ? widget.digits - 1
        : currentText.length;

    final bool isActive = index == activeIndex && _isFocused && widget.enabled;

    //  If filled, check tokenVisible. If false, obscure it with a clean standard bullet '•'.
    final String displayChar = isFilled
        ? (widget.tokenVisible ? currentText[index] : '•')
        : '';

    if (widget.variant == GbTokenFieldVariant.compressed) {
      final double originalSize = GbTokenFieldGeometry.boxSize(widget.size);
      final double scaleRatio = dynamicBoxSize / originalSize;

      return Container(
        width: dynamicBoxSize,
        height: dynamicBoxSize,
        decoration: BoxDecoration(
          color: GbTokenFieldTokens.backgroundColor(
            context,
            isDisabled: !widget.enabled,
          ),
          borderRadius: BorderRadius.circular(
            GbTokenFieldGeometry.borderRadius * scaleRatio,
          ),
          border: Border.all(
            color: GbTokenFieldTokens.borderColor(
              context,
              isActive: isActive,
              isDisabled: !widget.enabled,
            ),
            width: GbTokenFieldGeometry.borderWidth,
          ),
          boxShadow: GbTokenFieldGeometry.boxEdgeShadow,
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            displayChar,
            style: GbTokenFieldTokens.activeTextStyle(
              context,
              widget.size,
              isDisabled: !widget.enabled,
            ),
          ),
        ),
      );
    } else {
      return Container(
        constraints: const BoxConstraints(
          minWidth: GbTokenFieldGeometry.compactBoxMinWidth,
        ),
        height: GbTokenFieldGeometry.boxSize(widget.size),
        padding: GbTokenFieldGeometry.compactBoxPadding,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            GbTokenFieldGeometry.borderRadius,
          ),
        ),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (isFilled || !isActive)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  isFilled ? displayChar : '-',
                  style: isFilled
                      ? GbTokenFieldTokens.activeTextStyle(
                          context,
                          widget.size,
                          isDisabled: !widget.enabled,
                        )
                      : GbTokenFieldTokens.placeholderTextStyle(context),
                ),
              ),

            if (isActive)
              Positioned(
                right: isFilled ? 0 : null,
                child: const _BlinkingCursor(),
              ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment columnAlign;
    Alignment stackAlign;
    switch (widget.alignment) {
      case MainAxisAlignment.center:
        columnAlign = CrossAxisAlignment.center;
        stackAlign = Alignment.center;
        break;
      case MainAxisAlignment.end:
        columnAlign = CrossAxisAlignment.end;
        stackAlign = Alignment.centerRight;
        break;
      case MainAxisAlignment.start:
      default:
        columnAlign = CrossAxisAlignment.start;
        stackAlign = Alignment.centerLeft;
        break;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double dynamicBoxSize = GbTokenFieldGeometry.boxSize(widget.size);

        if (widget.variant == GbTokenFieldVariant.compressed) {
          double totalSpacingFor6 = 0;
          for (int i = 0; i < 5; i++) {
            if (i == 2) {
              totalSpacingFor6 +=
                  (GbTokenFieldGeometry.dividerSpacing(widget.size) * 2) + 16.0;
            } else {
              totalSpacingFor6 += GbTokenFieldGeometry.gap(widget.size);
            }
          }

          final double maxSafeBoxSize =
              (constraints.maxWidth - totalSpacingFor6) / 6;

          if (maxSafeBoxSize < dynamicBoxSize) {
            dynamicBoxSize = maxSafeBoxSize.floorToDouble();
          }
        }

        List<Widget> slots = [];
        final int halfPoint = widget.digits ~/ 2;

        for (int i = 0; i < widget.digits; i++) {
          slots.add(_buildTokenSlot(i, dynamicBoxSize));

          if (widget.variant == GbTokenFieldVariant.compressed) {
            if (widget.digits == 6 && i == halfPoint - 1) {
              slots.add(
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: GbTokenFieldGeometry.dividerSpacing(
                      widget.size,
                    ),
                  ),
                  child: Text(
                    '-',
                    style: GbTokenFieldTokens.dividerTextStyle(context),
                  ),
                ),
              );
            } else if (i != widget.digits - 1) {
              slots.add(SizedBox(width: GbTokenFieldGeometry.gap(widget.size)));
            }
          }
        }

        Widget tokenRow = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: slots,
        );

        if (widget.variant == GbTokenFieldVariant.compact) {
          tokenRow = Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: GbTokenFieldTokens.backgroundColor(
                context,
                isDisabled: !widget.enabled,
              ),
              borderRadius: BorderRadius.circular(
                GbTokenFieldGeometry.motherRadius,
              ),
              border: Border.all(
                color: GbTokenFieldTokens.borderColor(
                  context,
                  isActive: _isFocused,
                  isDisabled: !widget.enabled,
                ),
                width: GbTokenFieldGeometry.borderWidth,
              ),
              boxShadow: GbTokenFieldGeometry.boxEdgeShadow,
            ),
            child: tokenRow,
          );
        }

        return Column(
          crossAxisAlignment: columnAlign,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: GbTokenFieldTokens.labelTextStyle(context),
              ),
              const SizedBox(height: GbTokenFieldGeometry.labelToFieldSpacing),
            ],

            Stack(
              alignment: stackAlign,
              children: [
                tokenRow,
                Positioned.fill(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                        selectionColor: Colors.transparent,
                        selectionHandleColor: Colors.transparent,
                      ),
                    ),
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      enabled: widget.enabled,
                      keyboardType: TextInputType.number,
                      obscureText: !widget
                          .tokenVisible, //  OS-LEVEL SECURITY: Protects the input at the system level!
                      enableInteractiveSelection: true,
                      showCursor: false,
                      cursorColor: Colors.transparent,
                      style: const TextStyle(
                        color: Colors.transparent,
                        fontSize: 1,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        filled: false,
                        hoverColor: Colors.transparent,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(widget.digits),
                      ],
                      autofillHints: widget.tokenVisible
                          ? const [AutofillHints.oneTimeCode]
                          : const [
                              AutofillHints.password,
                            ], //  Swaps autofill hint based on security mode
                    ),
                  ),
                ),
              ],
            ),

            if (widget.hintText != null) ...[
              const SizedBox(height: GbTokenFieldGeometry.fieldToHintSpacing),
              Text(
                widget.hintText!,
                style: GbTokenFieldTokens.hintTextStyle(context),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2,
        height: 24,
        color: SemanticColors.of(context).borderSelected,
      ),
    );
  }
}
