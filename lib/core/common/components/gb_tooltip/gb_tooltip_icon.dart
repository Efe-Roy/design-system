import 'package:flutter/material.dart';
import 'gb_tooltip.dart'; // Import your visual tooltip

/// ℹ️ A reusable "Help Icon" that triggers a smart overlay tooltip.
/// This encapsulates all the alignment logic (Left/Right/Center)
/// so it behaves consistently across Inputs and Dropdowns.
class GbTooltipIcon extends StatefulWidget {
  const GbTooltipIcon({super.key, required this.message, required this.child});

  final String message;
  final Widget child;

  @override
  State<GbTooltipIcon> createState() => _GbTooltipIconState();
}

class _GbTooltipIconState extends State<GbTooltipIcon> {
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
    if (widget.message.isEmpty) return;

    final overlay = Overlay.of(context);
    final theme = Theme.of(context); // Capture theme
    final renderBox = context.findRenderObject() as RenderBox;

    // 🧠 1. Calculate Screen Position
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenWidth = MediaQuery.of(context).size.width;
    final iconCenterX = offset.dx + (renderBox.size.width / 2);

    // 🧠 2. Determine Position Logic (Copied from your Input Field work)
    Alignment targetAnchor;
    Alignment followerAnchor;
    Arrow arrowStyle;
    Offset positionOffset;

    if (iconCenterX > screenWidth * 0.75) {
      // ➡️ RIGHT EDGE CASE
      targetAnchor = Alignment.topRight;
      followerAnchor = Alignment.bottomRight;
      arrowStyle = Arrow.bottomRight;
      positionOffset = const Offset(28, 3);
    } else if (iconCenterX < screenWidth * 0.25) {
      // ⬅️ LEFT EDGE CASE
      targetAnchor = Alignment.topLeft;
      followerAnchor = Alignment.bottomLeft;
      arrowStyle = Arrow.bottomLeft;
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
          // 1. Invisible Detector (Tap outside to close)
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),

          // 2. The Smart Tooltip
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
                    child: GbTooltip(label: widget.message, arrow: arrowStyle),
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
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(onTap: _toggleTooltip, child: widget.child),
    );
  }
}
