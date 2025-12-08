import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isFullWidth;
  final bool isLoading;
  final Widget? iconBefore;
  final Widget? iconAfter;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final bool enabled;
  final bool isOutlined;
  final Color? borderColor;
  final double borderWidth;
  
  // Static design constants only
  static const double borderRadius = 12.0;
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 14.0;
  static const double gap = 8.0;
  static const double defaultHeight = 48.0;
  static const double iconSize = 20.0;
  static const double defaultBorderWidth = 1.5;
  
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.isFullWidth = true,
    this.isLoading = false,
    this.iconBefore,
    this.iconAfter,
    this.textStyle,
    this.width,
    this.height,
    this.enabled = true,
    this.isOutlined = false,
    this.borderColor,
    this.borderWidth = defaultBorderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = !enabled || isLoading;
    final Color effectiveBorderColor = borderColor ?? textColor;
    
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? defaultHeight,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isDisabled ? null : onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: textColor,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                side: BorderSide(
                  color: isDisabled
                      ? effectiveBorderColor.withOpacity(0.3)
                      : effectiveBorderColor,
                  width: borderWidth,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: _buildButtonContent(isDisabled),
            )
          : ElevatedButton(
              onPressed: isDisabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDisabled
                    ? backgroundColor.withOpacity(0.5)
                    : backgroundColor,
                foregroundColor: textColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: _buildButtonContent(isDisabled),
            ),
    );
  }

  Widget _buildButtonContent(bool isDisabled) {
    return isLoading
        ? SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOutlined ? textColor : Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconBefore != null) ...[
                iconBefore!,
                const SizedBox(width: gap),
              ],
              Flexible(
                child: Text(
                  text,
                  style: (textStyle ?? TextStyle(
                    color: isDisabled
                        ? textColor.withOpacity(isOutlined ? 0.5 : 0.7)
                        : textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (iconAfter != null) ...[
                const SizedBox(width: gap),
                iconAfter!,
              ],
            ],
          );
  }
}