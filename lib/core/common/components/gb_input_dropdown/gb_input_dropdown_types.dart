import 'package:flutter/material.dart';

enum GbInputDropdownType { normal, iconLeading, avatarLeading, dotLeading }

enum GbInputDropdownSize { sm, md }

enum GbInputDropdownState { normal, focused, disabled, filled }

class GbInputDropdownItem<T> {
  final T value;
  final String text;
  final String? supportingText;

  //  Dynamic Content
  final Widget? leading;
  final Color? dotColor;
  final String? countryCode;

  final bool enabled;

  const GbInputDropdownItem({
    required this.value,
    required this.text,
    this.supportingText,
    this.leading,
    this.dotColor,
    this.countryCode,
    this.enabled = true,
  });
}
