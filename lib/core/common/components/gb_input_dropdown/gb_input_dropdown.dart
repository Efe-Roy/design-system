import 'dart:math' as math;
import 'package:design_system/core/common/components/gb_input/gb_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/core/common/constants/gb_blur.dart';
import 'gb_input_dropdown_geometry.dart';
import 'gb_input_dropdown_tokens.dart';
import 'gb_input_dropdown_types.dart';
import 'gb_input_dropdown_menu_item.dart';
import 'package:design_system/core/common/components/gb_tooltip/gb_tooltip_icon.dart';
import 'package:design_system/core/common/components/gb_input/gb_input_types.dart';

class GbInputDropdown<T> extends StatefulWidget {
  const GbInputDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.label,
    this.hintText,
    this.placeholder,
    this.type = GbInputDropdownType.normal,
    this.size = GbInputDropdownSize.md,
    this.state = GbInputDropdownState.normal,
    this.enabled = true,
    this.toolTip,
    this.modalTitle,
    this.showSearch = false,
  });

  final List<GbInputDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hintText;
  final String? placeholder;
  final String? toolTip;
  final String? modalTitle;
  final bool showSearch;
  final GbInputDropdownType type;
  final GbInputDropdownSize size;
  final GbInputDropdownState state;
  final bool enabled;

  @override
  State<GbInputDropdown<T>> createState() => _GbInputDropdownState<T>();
}

class _GbInputDropdownState<T> extends State<GbInputDropdown<T>> {
  Widget _buildTriggerLeadingWidget(
    GbInputDropdownItem<T> item,
    Color iconColor,
  ) {
    if (widget.type == GbInputDropdownType.normal && item.countryCode != null) {
      return SvgPicture.asset(
        'assets/icons/flags/${item.countryCode!.toLowerCase()}.svg',
        width: GbInputDropdownGeometry.flagIconSize,
        height: GbInputDropdownGeometry.flagIconSize,
      );
    }
    if (item.leading != null) {
      if (widget.type == GbInputDropdownType.iconLeading) {
        return IconTheme(
          data: IconThemeData(
            size: GbInputDropdownGeometry.leadingIconSize,
            color: iconColor,
          ),
          child: item.leading!,
        );
      }
      return item.leading!;
    }
    if (widget.type == GbInputDropdownType.dotLeading &&
        item.dotColor != null) {
      return Container(
        width: GbInputDropdownGeometry.dotSize,
        height: GbInputDropdownGeometry.dotSize,
        decoration: BoxDecoration(color: item.dotColor, shape: BoxShape.circle),
      );
    }
    return const SizedBox.shrink();
  }

  void _openModal() {
    if (!widget.enabled || widget.state == GbInputDropdownState.disabled) {
      return;
    }

    List<GbInputDropdownItem<T>> modalFilteredItems = List.from(widget.items);
    bool isSuccessState = false; // Tracks if an item was just selected

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // We set these native colors to transparent so we can render our custom full-screen barrier inside
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final screenHeight = MediaQuery.of(context).size.height;
            final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

            return SizedBox(
              height:
                  screenHeight, // Force full screen to control the barrier entirely
              child: Stack(
                children: [
                  // 1. CUSTOM DYNAMIC BARRIER (Controls Blur and Blanket Color)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      behavior: HitTestBehavior.opaque,
                      child: GlobusBlur.applyBlur(
                        blurFilter: isSuccessState
                            ? GlobusBlur.lg
                            : GlobusBlur.vsm,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          color: isSuccessState
                              ? GbInputDropdownTokens.modalBarrierColorAfter(
                                  context,
                                )
                              : GbInputDropdownTokens.modalBarrierColorBefore(
                                  context,
                                ),
                        ),
                      ),
                    ),
                  ),

                  // 2. MODAL CONTENT BOX
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: GbInputDropdownGeometry.modalPaddingOuter,
                          right: GbInputDropdownGeometry.modalPaddingOuter,
                          top: GbInputDropdownGeometry.modalPaddingOuter,
                          bottom:
                              GbInputDropdownGeometry.modalPaddingOuter +
                              bottomInsets,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(
                          maxHeight: math.min(
                            GbInputDropdownGeometry.modalAbsoluteMaxHeight,
                            screenHeight * 0.9,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color:
                              GbInputDropdownTokens.modalContentBackgroundColor(
                                context,
                              ),
                          borderRadius: BorderRadius.circular(
                            GbInputDropdownGeometry.modalBorderRadius,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Drag Handle
                            Center(
                              child: Container(
                                width: GbInputDropdownGeometry.dragHandleWidth,
                                height:
                                    GbInputDropdownGeometry.dragHandleHeight,
                                margin: const EdgeInsets.only(
                                  top: GbInputDropdownGeometry
                                      .dragHandleTopMargin,
                                ),
                                decoration: BoxDecoration(
                                  color: GbInputDropdownTokens.dragHandleColor(
                                    context,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    GbInputDropdownGeometry.dragHandleHeight /
                                        2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Header Mother Container (Title & Search)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: GbInputDropdownGeometry
                                    .headerPaddingHorizontal,
                                vertical: GbInputDropdownGeometry
                                    .headerPaddingVertical,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.modalTitle != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: GbInputDropdownGeometry
                                            .titleBottomPadding,
                                      ),
                                      child: Text(
                                        widget.modalTitle!,
                                        style:
                                            GbInputDropdownTokens.modalTitleTextStyle(
                                              context,
                                            ),
                                      ),
                                    ),

                                  if (widget.showSearch)
                                    GbInputField(
                                      type: GbInputType.iconLeading,
                                      size: GbInputSize.sm,
                                      state: GbInputState.normal,
                                      placeholder: "Search",
                                      leadingIcon: SvgPicture.asset(
                                        'assets/icons/search.svg',
                                        width: GbInputDropdownGeometry
                                            .leadingIconSize,
                                        height: GbInputDropdownGeometry
                                            .leadingIconSize,
                                        colorFilter: ColorFilter.mode(
                                          GbInputDropdownTokens.iconColor(
                                            context,
                                            GbInputDropdownState.normal,
                                          ),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      onChanged: (query) {
                                        setModalState(() {
                                          if (query.isEmpty) {
                                            modalFilteredItems = List.from(
                                              widget.items,
                                            );
                                          } else {
                                            modalFilteredItems = widget.items
                                                .where((item) {
                                                  return item.text
                                                          .toLowerCase()
                                                          .contains(
                                                            query.toLowerCase(),
                                                          ) ||
                                                      (item.supportingText
                                                              ?.toLowerCase()
                                                              .contains(
                                                                query
                                                                    .toLowerCase(),
                                                              ) ??
                                                          false);
                                                })
                                                .toList();
                                          }
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ),

                            // Scrollable Item List
                            Flexible(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: modalFilteredItems.length,
                                itemBuilder: (context, index) {
                                  final item = modalFilteredItems[index];
                                  // In success state, manually force the selected item to look active
                                  final isSelected = isSuccessState
                                      ? (item.value == widget.value)
                                      : (item.value == widget.value);

                                  return GbInputDropdownMenuItem<T>(
                                    item: item,
                                    isSelected: isSelected,
                                    type: widget.type,
                                    onTap: () async {
                                      // 1. Trigger the Success Flash
                                      setModalState(() {
                                        isSuccessState = true;
                                        // Update the local selection purely for visual feedback during the flash
                                        widget.onChanged?.call(item.value);
                                      });

                                      // 2. Wait a split second to display the heavier blur and dark overlay
                                      await Future.delayed(
                                        const Duration(milliseconds: 300),
                                      );

                                      // 3. Close Modal
                                      if (mounted) {
                                        // ignore: use_build_context_synchronously
                                        if (Navigator.canPop(context)) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    GbInputDropdownItem<T>? selectedItem;
    try {
      if (widget.items.isNotEmpty && widget.value != null) {
        selectedItem = widget.items.firstWhere((i) => i.value == widget.value);
      }
    } catch (_) {}

    final bool hasSelection = selectedItem != null;
    final currentState = !widget.enabled
        ? GbInputDropdownState.disabled
        : widget.state;

    final borderColor = GbInputDropdownTokens.borderColor(
      context,
      currentState,
    );
    final bgColor = GbInputDropdownTokens.backgroundColor(
      context,
      currentState,
    );
    final textColor = GbInputDropdownTokens.inputTextStyle(
      context,
      widget.size,
      !widget.enabled,
    );
    final placeholderColor = GbInputDropdownTokens.placeholderTextStyle(
      context,
      widget.size,
    );
    final iconColor = GbInputDropdownTokens.iconColor(context, currentState);

    Widget trigger = GestureDetector(
      onTap: _openModal,
      child: Container(
        height: GbInputDropdownGeometry.height(widget.size),
        padding: EdgeInsets.symmetric(
          horizontal: GbInputDropdownGeometry.paddingHorizontal(widget.size),
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
            GbInputDropdownGeometry.borderRadius(widget.size),
          ),
          border: Border.all(
            color: borderColor,
            width: GbInputDropdownTokens.borderWidth(currentState),
          ),
        ),
        child: Row(
          children: [
            if (hasSelection) ...[
              _buildTriggerLeadingWidget(selectedItem, iconColor),
              if (selectedItem.leading != null ||
                  selectedItem.countryCode != null ||
                  selectedItem.dotColor != null)
                const SizedBox(width: GbInputDropdownGeometry.contentGap),
            ],

            Expanded(
              child: Text(
                hasSelection
                    ? selectedItem.text
                    : (widget.placeholder ?? "Select..."),
                style: hasSelection ? textColor : placeholderColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            if (widget.toolTip != null) ...[
              const SizedBox(width: 8),
              GbTooltipIcon(
                message: widget.toolTip!,
                child: SvgPicture.asset(
                  'assets/icons/help.svg',
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ],

            const SizedBox(width: GbInputDropdownGeometry.trailingIconGap),
            SvgPicture.asset(
              'assets/icons/dropdown_icon.svg',
              width: GbInputDropdownGeometry.chevronSize,
              height: GbInputDropdownGeometry.chevronSize,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: GbInputDropdownTokens.labelTextStyle(context),
          ),
          const SizedBox(height: GbInputDropdownGeometry.labelToFieldSpacing),
        ],
        trigger,
        if (widget.hintText != null) ...[
          const SizedBox(height: GbInputDropdownGeometry.fieldToHintSpacing),
          Text(
            widget.hintText!,
            style: GbInputDropdownTokens.hintTextStyle(context),
          ),
        ],
      ],
    );
  }
}
