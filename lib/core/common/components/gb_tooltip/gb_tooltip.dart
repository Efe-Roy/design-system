import 'package:design_system/core/common/constants/gb_semantic_tokens.dart';
import 'package:design_system/core/common/constants/gb_shadow.dart';
import 'package:flutter/material.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';

/// Defines where the tooltip arrow points
enum Arrow {
  none,
  topCenter,
  bottomCenter,
  bottomLeft,
  bottomRight,
  left,
  right,
}

class GbTooltip extends StatelessWidget {
  const GbTooltip({
    super.key,
    required this.label,
    this.supportingText,
    this.arrow = Arrow.bottomCenter,
  });

  final String label;
  final String? supportingText;
  final Arrow arrow;

  @override
  Widget build(BuildContext context) {
    final SemanticColors colors = SemanticColors.of(context);

    // Typography
    final TextStyle labelStyle = GlobusTypography.textXsSemiBold.copyWith(
      color: colors.text,
    );
    final TextStyle supportStyle = GlobusTypography.textXsRegular.copyWith(
      color: colors.textSubtle,
    );

    return CustomPaint(
      painter: _TooltipPainter(
        color: colors.surfaceBold,
        borderColor: colors.borderSubtler,
        arrow: arrow,
        shadow: GlobusShadows.sm,
      ),
      child: Padding(
        padding: _getPaddingWithArrow(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: labelStyle),
            if (supportingText != null) ...[
              const SizedBox(height: 8.0),
              Text(supportingText!, style: supportStyle),
            ],
          ],
        ),
      ),
    );
  }

  /// Calculates padding to prevent content overlap + room for shadow
  EdgeInsets _getPaddingWithArrow() {
    const double inset = 4.0;
    const double visualPadding = 12.0;
    const double contentPadding = visualPadding + inset;

    const double arrowHeight = 8.0;

    double left = contentPadding;
    double top = contentPadding;
    double right = contentPadding;
    double bottom = contentPadding;

    switch (arrow) {
      case Arrow.topCenter:
        top += arrowHeight;
        break;
      case Arrow.bottomCenter:
      case Arrow.bottomLeft:
      case Arrow.bottomRight:
        bottom += arrowHeight;
        break;
      case Arrow.left:
        left += arrowHeight;
        break;
      case Arrow.right:
        right += arrowHeight;
        break;
      case Arrow.none:
        break;
    }

    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }
}

/// 🎨 THE PAINTER
class _TooltipPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final Arrow arrow;
  final BoxShadow shadow;

  _TooltipPainter({
    required this.color,
    required this.borderColor,
    required this.arrow,
    required this.shadow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Path path = _getTooltipPath(size);

    // 1. Draw Shadow
    canvas.drawShadow(path, shadow.color, shadow.blurRadius, true);

    // 2. Draw Fill
    canvas.drawPath(path, paint);

    // 3. Draw Border
    canvas.drawPath(path, borderPaint);
  }

  Path _getTooltipPath(Size size) {
    final Path path = Path();
    const double radius = 8.0;

    //  ARROW GEOMETRY
    const double arrowBase = 16.0;
    const double arrowHeight = 12.0;
    const double edgeOffset = 24.0;

    // INSET: 4.0px
    const double inset = 4.0;

    double left = inset;
    double top = inset;
    double right = size.width - inset;
    double bottom = size.height - inset;

    // Adjust box bounds to make room for arrow
    switch (arrow) {
      case Arrow.topCenter:
        top += arrowHeight;
        break;
      case Arrow.bottomCenter:
      case Arrow.bottomLeft:
      case Arrow.bottomRight:
        bottom -= arrowHeight;
        break;
      case Arrow.left:
        left += arrowHeight;
        break;
      case Arrow.right:
        right -= arrowHeight;
        break;
      default:
        break;
    }

    //  DRAWING LOOP (Clockwise: Top -> Right -> Bottom -> Left)

    // START: Top-Left Radius End
    path.moveTo(left + radius, top);

    // 1. TOP EDGE
    if (arrow == Arrow.topCenter) {
      final center = (left + right) / 2;
      path.lineTo(center - (arrowBase / 2), top);
      _drawArrowTip(path, center, top - arrowHeight, isPointingUp: true);
      path.lineTo(center + (arrowBase / 2), top);
    }
    path.lineTo(right - radius, top);
    path.arcToPoint(
      Offset(right, top + radius),
      radius: Radius.circular(radius),
    );

    // 2. RIGHT EDGE
    if (arrow == Arrow.right) {
      final center = (top + bottom) / 2;
      path.lineTo(right, center - (arrowBase / 2));
      _drawArrowTip(
        path,
        right + arrowHeight,
        center,
        isPointingUp: false,
        isVertical: false,
      );
      path.lineTo(right, center + (arrowBase / 2));
    }
    path.lineTo(right, bottom - radius);
    path.arcToPoint(
      Offset(right - radius, bottom),
      radius: Radius.circular(radius),
    );

    // 3. BOTTOM EDGE (Drawing Right to Left)
    if (arrow == Arrow.bottomRight) {
      final arrowStart = right - edgeOffset;
      final arrowEnd = arrowStart - arrowBase;

      path.lineTo(arrowStart, bottom);
      _drawArrowTip(
        path,
        arrowStart - (arrowBase / 2),
        bottom + arrowHeight,
        isPointingUp: false,
      );
      path.lineTo(arrowEnd, bottom);
    } else if (arrow == Arrow.bottomCenter) {
      final center = (left + right) / 2;
      path.lineTo(center + (arrowBase / 2), bottom);
      _drawArrowTip(path, center, bottom + arrowHeight, isPointingUp: false);
      path.lineTo(center - (arrowBase / 2), bottom);
    } else if (arrow == Arrow.bottomLeft) {
      final arrowEnd = left + edgeOffset;
      final arrowStart = arrowEnd + arrowBase;

      path.lineTo(arrowStart, bottom);
      _drawArrowTip(
        path,
        arrowStart - (arrowBase / 2),
        bottom + arrowHeight,
        isPointingUp: false,
      );
      path.lineTo(arrowEnd, bottom);
    }

    path.lineTo(left + radius, bottom);
    path.arcToPoint(
      Offset(left, bottom - radius),
      radius: Radius.circular(radius),
    );

    // 4. LEFT EDGE (Drawing Bottom to Top)
    if (arrow == Arrow.left) {
      final center = (top + bottom) / 2;
      path.lineTo(left, center + (arrowBase / 2));
      _drawArrowTip(
        path,
        left - arrowHeight,
        center,
        isPointingUp: true,
        isVertical: false,
      );
      path.lineTo(left, center - (arrowBase / 2));
    }
    path.lineTo(left, top + radius);
    path.arcToPoint(
      Offset(left + radius, top),
      radius: Radius.circular(radius),
    );

    path.close();
    return path;
  }

  /// Helper to draw a rounded 90-degree tip
  void _drawArrowTip(
    Path path,
    double tipX,
    double tipY, {
    bool isVertical = true,
    bool isPointingUp = true,
  }) {
    const double offset = 1.0; // Controls how "pointy" vs "rounded" the tip is

    if (isVertical) {
      if (isPointingUp) {
        // Pointing Up
        path.lineTo(tipX - offset, tipY + offset);
        path.quadraticBezierTo(tipX, tipY, tipX + offset, tipY + offset);
      } else {
        // Pointing Down
        path.lineTo(tipX + offset, tipY - offset);
        path.quadraticBezierTo(tipX, tipY, tipX - offset, tipY - offset);
      }
    } else {
      // Horizontal Arrows
      if (!isPointingUp) {
        // Right Arrow
        path.lineTo(tipX - offset, tipY - offset);
        path.quadraticBezierTo(tipX, tipY, tipX - offset, tipY + offset);
      } else {
        // Left Arrow
        path.lineTo(tipX + offset, tipY + offset);
        path.quadraticBezierTo(tipX, tipY, tipX + offset, tipY - offset);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TooltipPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.arrow != arrow;
  }
}
