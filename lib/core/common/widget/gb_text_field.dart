import 'package:flutter/material.dart';

class GBTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final Widget?
  suffix; // Custom suffix (dropdown, icon, etc.) that comes BEFORE clear button
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final bool showClearButton;
  final Color? clearButtonColor;
  final double? clearButtonSize;
  final EdgeInsets? clearButtonPadding;
  final bool showHelpIcon; // Show help/alert circle icon
  final String? helpText; // Text to show when help icon is tapped
  final Color? helpIconColor;
  final Color? errorIconColor;
  final double? helpIconSize;
  final VoidCallback? onHelpIconTap;
  final bool isPasswordField; // Special handling for password fields
  final bool prefixOutsideBorder;

  const GBTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefix,
    this.suffix,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.contentPadding,
    this.showClearButton = true,
    this.clearButtonColor,
    this.clearButtonSize = 20,
    this.clearButtonPadding,
    this.showHelpIcon = false,
    this.helpText,
    this.helpIconColor,
    this.errorIconColor,
    this.helpIconSize = 18,
    this.onHelpIconTap,
    this.isPasswordField = false,
    this.prefixOutsideBorder = false,
  });

  @override
  State<GBTextField> createState() => _GBTextFieldState();
}

class _GBTextFieldState extends State<GBTextField> {
  bool _isValid = true;
  String? _errorText;
  late FocusNode _internalFocusNode;
  late TextEditingController _internalController;
  final bool _showHelpTooltip = false;
  bool _obscureText = true; // For password visibility toggle

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalController = widget.controller;
    _obscureText = widget.obscureText; // Initialize with widget value

    _internalFocusNode.addListener(_onFocusChange);
    _internalController.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(GBTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onTextChanged);
      widget.controller.addListener(_onTextChanged);
      _internalController = widget.controller;
    }

    // Update obscure text if widget property changed
    if (oldWidget.obscureText != widget.obscureText) {
      _obscureText = widget.obscureText;
    }
  }

  @override
  void dispose() {
    _internalController.removeListener(_onTextChanged);
    _internalFocusNode.removeListener(_onFocusChange);

    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }

    super.dispose();
  }

  void _onTextChanged() {
    if (widget.validator != null) {
      final error = widget.validator!(_internalController.text);
      if (mounted) {
        setState(() {
          _isValid = error == null;
          _errorText = error;
        });
      }
    } else if (mounted) {
      setState(() {});
    }
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _clearText() {
    _internalController.clear();
    _internalFocusNode.requestFocus();

    if (widget.onChanged != null) {
      widget.onChanged!('');
    }

    _onTextChanged();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildHelpIcon() {
    if (!widget.showHelpIcon) return const SizedBox.shrink();

    final iconColor = _isValid
        ? (widget.helpIconColor ?? Colors.grey[500])
        : (widget.errorIconColor ?? Theme.of(context).colorScheme.error);

    final icon = _isValid ? Icons.help_outline : Icons.error_outline;

    return GestureDetector(
      onTap: () {
        if (widget.onHelpIconTap != null) {
          widget.onHelpIconTap!();
        } else if (widget.helpText != null) {
          _showHelpDialog(context);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Icon(icon, size: widget.helpIconSize, color: iconColor),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isValid ? 'Help' : 'Error'),
        content: Text(_isValid ? widget.helpText! : _errorText!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Build password visibility toggle icon
  Widget _buildPasswordVisibilityToggle() {
    if (!widget.isPasswordField && !widget.obscureText) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: _togglePasswordVisibility,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Text(
            _obscureText ? 'SHOW' : 'HIDE',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black, // Using black for high contrast
            ),
          ),
        ),
      ),
    );
  }

  // Build the combined suffix with clear button LAST and help icon if needed
  Widget _buildSuffix() {
    final hasText = _internalController.text.isNotEmpty;
    final isFocused = _internalFocusNode.hasFocus;
    final showClear =
        widget.showClearButton && hasText && isFocused && widget.enabled;

    // Build children in order
    final children = <Widget>[];

    // 1. Help/Error icon (always visible if showHelpIcon is true)
    if (widget.showHelpIcon) {
      children.add(_buildHelpIcon());
      if (widget.suffix != null || showClear || widget.isPasswordField) {
        children.add(const SizedBox(width: 4));
      }
    }

    // 2. Password visibility toggle (for password fields)
    if (widget.isPasswordField || widget.obscureText) {
      children.add(_buildPasswordVisibilityToggle());
      if (widget.suffix != null || showClear) {
        children.add(const SizedBox(width: 4));
      }
    }

    // 3. Add custom suffix if provided
    if (widget.suffix != null) {
      children.add(widget.suffix!);
      if (showClear) {
        children.add(const SizedBox(width: 8));
      }
    }

    // 4. Add clear button LAST (if shown)
    if (showClear) {
      children.add(
        GestureDetector(
          onTap: _clearText,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: widget.clearButtonPadding ?? const EdgeInsets.all(4.0),
            child: Icon(
              Icons.clear,
              size: widget.clearButtonSize,
              color: widget.clearButtonColor ?? Colors.grey[600],
            ),
          ),
        ),
      );
    }

    // If no children, return empty SizedBox
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    // Add spacing at the end
    children.add(const SizedBox(width: 8));

    // Return as a Row with all children
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine if we should show password visibility toggle
    final shouldShowPasswordToggle =
        widget.isPasswordField || widget.obscureText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label at the top (only if provided)
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.labelText!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _isValid
                          ? Colors.grey[700]
                          : Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Optional help icon in the label area
                if (widget.showHelpIcon && widget.helpText != null && _isValid)
                  GestureDetector(
                    onTap: () => _showHelpDialog(context),
                    child: Icon(
                      Icons.help_outline,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),

        // Text field with prefix/suffix
        // Text field with prefix/suffix
        if (widget.prefixOutsideBorder && widget.prefix != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: widget.prefix,
              ),
              Expanded(
                child: TextFormField(
                  controller: _internalController,
                  validator: widget.validator,
                  keyboardType: widget.keyboardType,
                  cursorColor: Colors.black,
                  obscureText: shouldShowPasswordToggle
                      ? _obscureText
                      : widget.obscureText,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  enabled: widget.enabled,
                  onChanged: (value) {
                    widget.onChanged?.call(value);
                    _onTextChanged();
                  },
                  onTap: widget.onTap,
                  focusNode: _internalFocusNode,
                  textInputAction: widget.textInputAction,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  autofocus: widget.autofocus,
                  onTapOutside: (_) {
                    _onTextChanged();
                    _internalFocusNode.unfocus();
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        widget.contentPadding ??
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                    // Prefix is handled outside
                    prefixIcon: null,
                    suffixIcon: _buildSuffix(),
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    filled: true,
                    fillColor: widget.enabled
                        ? Colors.grey[50]
                        : Colors.grey[200],
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _isValid
                            ? Colors.grey[300]!
                            : Theme.of(context).colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _isValid
                            ? Colors.grey[300]!
                            : Theme.of(context).colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _isValid
                            ? Colors.blue
                            : Theme.of(context).colorScheme.error,
                        width: 2.0,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 2.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          TextFormField(
            controller: _internalController,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            cursorColor: Colors.black,
            obscureText: shouldShowPasswordToggle
                ? _obscureText
                : widget.obscureText,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            enabled: widget.enabled,
            onChanged: (value) {
              widget.onChanged?.call(value);
              _onTextChanged();
            },
            onTap: widget.onTap,
            focusNode: _internalFocusNode,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            autofocus: widget.autofocus,
            onTapOutside: (_) {
              _onTextChanged();
              _internalFocusNode.unfocus();
            },
            decoration: InputDecoration(
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              prefixIcon: widget.prefix != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: widget.prefix,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              suffixIcon: _buildSuffix(),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              filled: true,
              fillColor: widget.enabled ? Colors.grey[50] : Colors.grey[200],
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _isValid
                      ? Colors.grey[300]!
                      : Theme.of(context).colorScheme.error,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _isValid
                      ? Colors.grey[300]!
                      : Theme.of(context).colorScheme.error,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _isValid
                      ? Colors.blue
                      : Theme.of(context).colorScheme.error,
                  width: 2.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 2.0,
                ),
              ),
            ),
          ),

        // Hint/Error text below
        if (_errorText != null ||
            (widget.hintText != null && _errorText == null))
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Error/help icon next to text
                if (_errorText != null ||
                    (widget.showHelpIcon && widget.helpText != null))
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0, top: 1.0),
                    child: Icon(
                      _errorText != null
                          ? Icons.error_outline
                          : Icons.help_outline,
                      size: 14,
                      color: _errorText != null
                          ? Theme.of(context).colorScheme.error
                          : Colors.grey[500],
                    ),
                  ),
                Expanded(
                  child: Text(
                    _errorText ?? widget.hintText!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _errorText != null
                          ? Theme.of(context).colorScheme.error
                          : Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
