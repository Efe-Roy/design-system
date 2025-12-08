import 'package:flutter/material.dart';

class GlobusShadows {
  // Simple shadow tokens (based on Figma)
  static const BoxShadow xs = BoxShadow(
    color: Color(0x0C101828), // Black with ~5% opacity
    blurRadius: 2.0,
    spreadRadius: 0.0,
    offset: Offset(0, 1),
  );

  static const BoxShadow sm = BoxShadow(
    color: Color(0x0F101828),
    blurRadius: 2.0,
    spreadRadius: 0.0,
    offset: Offset(0, 1),
  );

  static const BoxShadow md = BoxShadow(
    color: Color(0x0F101828),
    blurRadius: 4.0,
    spreadRadius: -2.0,
    offset: Offset(0, 2),
  );

  static const BoxShadow lg = BoxShadow(
    color: Color(0x07101828),
    blurRadius: 6.0,
    spreadRadius: -2.0,
    offset: Offset(0, 4),
  );

  static const BoxShadow xl = BoxShadow(
    color: Color(0x07101828),
    blurRadius: 8.0,
    spreadRadius: -4.0,
    offset: Offset(0, 8),
  );

  static const BoxShadow x2l = BoxShadow(
    color: Color(0x2D0F1728),
    blurRadius: 48.0,
    spreadRadius: -12.0,
    offset: Offset(0, 24),
  );

  static const BoxShadow x3l = BoxShadow(
    color: Color(0x230F1728),
    blurRadius: 64.0,
    spreadRadius: -12.0,
    offset: Offset(0, 32),
  );
}
