import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import '../gb_input_geometry.dart';
import '../gb_input_tokens.dart';
import '../gb_input_types.dart';
import '../gb_input_state.dart';
//import 'package:design_system/blocs/theme/gb_semantic_tokens.dart';

class GbTagData {
  final String label;
  final String? imageUrl; // Null = Text only tag
  const GbTagData({required this.label, this.imageUrl});
}

class GbInputTags extends StatefulWidget {
  const GbInputTags({
    super.key,
    required this.size,
    required this.enabled,
    required this.destructive,
    required this.state,
    required this.tags,
    required this.onTagDeleted,
    this.onFieldSubmitted,
    this.suggestionsCallback,
    this.onSuggestionSelected,
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

  final List<GbTagData> tags;
  final ValueChanged<GbTagData> onTagDeleted;
  final ValueChanged<String>? onFieldSubmitted;

  final Future<List<GbTagData>> Function(String)? suggestionsCallback;
  final ValueChanged<GbTagData>? onSuggestionSelected;

  final String? label;
  final String? placeholder;
  final String? helperText;

  // ✅ 2. Added Smart Icon Field
  final Widget? statusIcon;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  @override
  State<GbInputTags> createState() => _GbInputTagsState();
}

class _GbInputTagsState extends State<GbInputTags> {
  // 🗑️ DELETED: Old hardcoded icon assets

  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_handleStateChange);
  }

  void _handleStateChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleStateChange);
    if (widget.focusNode == null) _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1️⃣ Resolve Intent & Styles
    final intent = GbInputStateResolver.toVisualIntent(
      state: widget.state,
      destructive: widget.destructive,
    );
    final effectiveEnabled =
        widget.enabled && widget.state != GbInputState.disabled;

    final minHeight = GbInputGeometry.height(widget.size);
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

    // 2️⃣ The Autocomplete Widget
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: GbInputTokens.labelTextStyle()),
          const SizedBox(height: GbInputGeometry.labelToFieldSpacing),
        ],

        RawAutocomplete<GbTagData>(
          textEditingController: _controller,
          focusNode: _focusNode,

          optionsBuilder: (TextEditingValue textEditingValue) async {
            if (widget.suggestionsCallback == null) return [];
            if (textEditingValue.text.isEmpty) return [];
            return await widget.suggestionsCallback!(textEditingValue.text);
          },

          onSelected: (GbTagData selection) {
            widget.onSuggestionSelected?.call(selection);
            _controller.clear();
          },

          // ✅ FIELD BUILDER: Layout with Icons
          fieldViewBuilder:
              (context, textController, focusNode, onFieldSubmitted) {
                return GestureDetector(
                  onTap: () {
                    if (effectiveEnabled) focusNode.requestFocus();
                  },
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        constraints: BoxConstraints(minHeight: minHeight),
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: GbInputGeometry.paddingLeft(widget.size),
                          // Add padding on right to avoid overlapping the icon
                          right:
                              GbInputGeometry.paddingLeft(widget.size) + 24.0,
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(radius),
                          border: Border.all(
                            color: borderColor,
                            width: borderWidth,
                          ),
                        ),
                        child: Wrap(
                          spacing: GbInputGeometry.chipGap,
                          runSpacing: GbInputGeometry.chipRunSpacing,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ...widget.tags.map(
                              (tag) => _GbChip(
                                data: tag,
                                enabled: effectiveEnabled,
                                onDeleted: () => widget.onTagDeleted(tag),
                                size: widget.size,
                              ),
                            ),

                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 60,
                                maxWidth: 200,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: textController,
                                  focusNode: focusNode,
                                  enabled: effectiveEnabled,
                                  style: inputStyle,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                    hintText:
                                        (widget.tags.isEmpty &&
                                            textController.text.isEmpty)
                                        ? widget.placeholder
                                        : null,
                                    hintStyle: hintStyle,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  onChanged: widget.onChanged,
                                  onSubmitted: (v) {
                                    if (v.trim().isNotEmpty) {
                                      widget.onFieldSubmitted?.call(v);
                                      textController.clear();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ✅ 3. NEW: Positioned Smart Icon
                      if (widget.statusIcon != null)
                        Positioned(
                          right: GbInputGeometry.paddingLeft(widget.size),
                          top: 0,
                          bottom: 0,
                          child: Center(child: widget.statusIcon!),
                        ),
                    ],
                  ),
                );
              },

          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 300,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final GbTagData option = options.elementAt(index);
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              if (option.imageUrl != null) ...[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    option.imageUrl!,
                                  ),
                                  radius: 12,
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                option.label,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),

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

// 🛠️ PRIVATE CHIP WIDGET (Unchanged)
class _GbChip extends StatelessWidget {
  const _GbChip({
    required this.data,
    required this.enabled,
    required this.onDeleted,
    required this.size,
  });

  final GbTagData data;
  final bool enabled;
  final VoidCallback onDeleted;
  final GbInputSize size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GbInputGeometry.chipHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: GbInputGeometry.chipPaddingHorizontal,
      ),
      decoration: BoxDecoration(
        color: GbInputTokens.chipBackgroundColor(context, enabled: enabled),
        borderRadius: BorderRadius.circular(GbInputGeometry.chipBorderRadius),
        border: Border.all(
          color: GbInputTokens.chipBorderColor(context),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (data.imageUrl != null) ...[
            Container(
              width: GbInputGeometry.chipAvatarSize,
              height: GbInputGeometry.chipAvatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(data.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: GbInputGeometry.chipContentSpacing),
          ],
          Text(
            data.label,
            style: GbInputTokens.chipTextStyle(size).copyWith(
              color: GbInputTokens.chipTextColor(context, enabled: enabled),
              fontSize: 12,
            ),
          ),
          const SizedBox(width: GbInputGeometry.chipContentSpacing),
          GestureDetector(
            onTap: enabled ? onDeleted : null,
            child: Icon(
              Icons.close,
              size: 14,
              color: GbInputTokens.chipTextColor(context, enabled: enabled),
            ),
          ),
        ],
      ),
    );
  }
}
