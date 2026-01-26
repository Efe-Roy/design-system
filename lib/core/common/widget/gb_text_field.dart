import 'package:flutter/material.dart';

class GBTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
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
  final bool showHelpIcon;
  final String? helpText;
  final Color? helpIconColor;
  final Color? errorIconColor;
  final double? helpIconSize;
  final VoidCallback? onHelpIconTap;
  final bool isPasswordField;
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
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalController = widget.controller;
    _obscureText = widget.obscureText;

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
    widget.onChanged?.call('');
    _onTextChanged();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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

  OutlineInputBorder _buildBorder({
    required bool isError,
    required bool isFocused,
    bool isDisabled = false,
    bool usePartialRadius = false,
  }) {
    Color borderColor;
    double borderWidth;

    if (isDisabled) {
      borderColor = Colors.grey[300]!;
      borderWidth = 1.5;
    } else if (isError) {
      borderColor = Theme.of(context).colorScheme.error;
      borderWidth = 2.0;
    } else if (isFocused) {
      borderColor = Colors.blue;
      borderWidth = 2.0;
    } else {
      borderColor = Colors.grey[300]!;
      borderWidth = 1.5;
    }

    return OutlineInputBorder(
      borderRadius: usePartialRadius
          ? const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            )
          : BorderRadius.circular(8),
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );
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
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuffix() {
    final hasText = _internalController.text.isNotEmpty;
    final showClear =
        widget.showClearButton &&
        hasText &&
        _internalFocusNode.hasFocus &&
        widget.enabled;

    final children = <Widget>[
      if (widget.showHelpIcon) ...[_buildHelpIcon(), const SizedBox(width: 4)],
      if (widget.isPasswordField || widget.obscureText) ...[
        _buildPasswordVisibilityToggle(),
        const SizedBox(width: 4),
      ],
      if (widget.suffix != null) ...[widget.suffix!, const SizedBox(width: 8)],
      if (showClear)
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
      const SizedBox(width: 8),
    ];

    return children.length <= 1
        ? const SizedBox.shrink()
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: children,
          );
  }

  Widget _buildLabel() {
    return Padding(
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
    );
  }

  Widget _buildTextFormField({bool hasExternalPrefix = false}) {
    final shouldShowPasswordToggle =
        widget.isPasswordField || widget.obscureText;

    return TextFormField(
      controller: _internalController,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      cursorColor: Colors.black,
      obscureText: shouldShowPasswordToggle ? _obscureText : widget.obscureText,
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
        prefixIcon: !hasExternalPrefix && widget.prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: widget.prefix,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: _buildSuffix(),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: widget.enabled ? Colors.grey[50] : Colors.grey[200],
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: _buildBorder(
          isError: !_isValid,
          isFocused: false,
          usePartialRadius: hasExternalPrefix,
        ),
        enabledBorder: _buildBorder(
          isError: !_isValid,
          isFocused: false,
          usePartialRadius: hasExternalPrefix,
        ),
        focusedBorder: _buildBorder(
          isError: !_isValid,
          isFocused: true,
          usePartialRadius: hasExternalPrefix,
        ),
        disabledBorder: _buildBorder(
          isError: false,
          isFocused: false,
          isDisabled: true,
        ),
        errorBorder: _buildBorder(isError: true, isFocused: false),
        focusedErrorBorder: _buildBorder(isError: true, isFocused: true),
      ),
    );
  }

  Widget _buildHintOrError() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_errorText != null ||
              (widget.showHelpIcon && widget.helpText != null))
            Padding(
              padding: const EdgeInsets.only(right: 4.0, top: 1.0),
              child: Icon(
                _errorText != null ? Icons.error_outline : Icons.help_outline,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) _buildLabel(),

        if (widget.prefixOutsideBorder && widget.prefix != null)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: widget.prefix,
                ),
                Expanded(child: _buildTextFormField(hasExternalPrefix: true)),
              ],
            ),
          )
        else
          _buildTextFormField(),

        if (_errorText != null ||
            (widget.hintText != null && _errorText == null))
          _buildHintOrError(),
      ],
    );
  }
}
