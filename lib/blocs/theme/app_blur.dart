import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GlobusBlur {
  static final ui.ImageFilter sm = ui.ImageFilter.blur(
    sigmaX: 8.0,
    sigmaY: 8.0,
  );
  static final ui.ImageFilter md = ui.ImageFilter.blur(
    sigmaX: 16.0,
    sigmaY: 16.0,
  );
  static final ui.ImageFilter lg = ui.ImageFilter.blur(
    sigmaX: 24.0,
    sigmaY: 24.0,
  );
  static final ui.ImageFilter xl = ui.ImageFilter.blur(
    sigmaX: 40.0,
    sigmaY: 40.0,
  );

  static Widget applyBlur({
    required Widget child,
    required ui.ImageFilter blurFilter,
  }) {
    return BackdropFilter(filter: blurFilter, child: child);
  }
}


//-----------Sample use case----------------

// GlobusBlur.applyBlur(
//   blurFilter: GlobusBlur.md,
//   child: Container(
//     padding: EdgeInsets.all(16),
//     color: Colors.white.withOpacity(0.8),
//     child: Text(
//       'This is a BLURRY test!',
//       style: GlobusTypography.displaySmBold.copyWith(
//         color: GlobusColorTokens.textBold(isDarkMode: false),
//       ),
//     ),
//   ),
// ),