// import 'package:flutter/material.dart';

// import 'gb_input_geometry.dart';
// import 'gb_input_tokens.dart';
// import 'gb_input_state.dart';
// import 'gb_input_types.dart';

// class GbInputPassword extends StatefulWidget {
//   const GbInputPassword({
//     super.key,
//     required this.size,
//     required this.state,
//     this.label,
//     this.hintText,
//     this.helperText,
//     this.controller,
//     this.focusNode,
//     this.onChanged,
//   });

//   final GbInputSize size;
//   final GbInputState state;

//   final String? label;
//   final String? hintText;
//   final String? helperText;

//   final TextEditingController? controller;
//   final FocusNode? focusNode;

//   final ValueChanged<String>? onChanged;

//   @override
//   State<GbInputPassword> createState() => _GbInputPasswordState();
// }

// class _GbInputPasswordState extends State<GbInputPassword> {
//   static const String _helpIconAsset = 'assets/icons/help.svg';
//   static const String _errorIconAsset = 'assets/icons/error.svg';

//   late final FocusNode _focusNode;
//   bool _hasValue = false;
//   bool _obscured = true;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode = widget.focusNode ?? FocusNode();
//     _focusNode.addListener(() => setState(() {}));
//     _hasValue = widget.controller?.text.isNotEmpty ?? false;
//   }

//   @override
//   void dispose() {
//     if (widget.focusNode == null) {
//       _focusNode.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ─────────────────────────────────────────────
//     // 1️⃣ Visual intent
//     // ─────────────────────────────────────────────
//     final intent = GbInputStateResolver.toVisualIntent(
//       state: widget.state,
//       enabled: widget.state != GbInputState.disabled,
//       destructive: false, // password error handled via state mapping
//     );

//     final bool isDisabled = widget.state == GbInputState.disabled;

//     // ─────────────────────────────────────────────
//     // 2️⃣ Geometry
//     // ─────────────────────────────────────────────
//     final height = GbInputGeometry.height(widget.size);
//     final radius = GbInputGeometry.borderRadius(widget.size);

//     final toggleWidth = GbInputGeometry.passwordToggleWidth(widget.size);
//     final toggleHeight = GbInputGeometry.passwordToggleHeight(widget.size);

//     // ─────────────────────────────────────────────
//     // 3️⃣ Tokens
//     // ─────────────────────────────────────────────
//     final borderColor = GbInputTokens.borderColor(context, intent);
//     final borderWidth = GbInputTokens.borderWidth(intent);
//     final backgroundColor = GbInputTokens.backgroundColor(context, intent);

//     final inputTextStyle = GbInputTokens.inputTextStyle(widget.size).copyWith(
//       color: GbInputTokens.inputTextColor(
//         context,
//         enabled: !isDisabled,
//         isnormal: false,
//       ),
//     );

//     final hintStyle = GbInputTokens.inputTextStyle(widget.size).copyWith(
//       color: GbInputTokens.inputTextColor(
//         context,
//         enabled: !isDisabled,
//         isnormal: !_hasValue,
//       ),
//     );

//     // ─────────────────────────────────────────────
//     // 4️⃣ Field
//     // ─────────────────────────────────────────────
//     final field = Container(
//       height: height,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(radius),
//         border: Border.all(color: borderColor, width: borderWidth),
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: GbInputGeometry.paddingLeft(widget.size),
//       ),
//       child: Row(
//         children: [
//           // ───── Text field ─────
//           Expanded(
//             child: TextField(
//               controller: widget.controller,
//               focusNode: _focusNode,
//               enabled: !isDisabled,
//               obscureText: _obscured,
//               style: inputTextStyle,
//               decoration: InputDecoration(
//                 isCollapsed: true,
//                 border: InputBorder.none,
//                 hintText: widget.hintText,
//                 hintStyle: hintStyle,
//               ),
//               onChanged: (v) {
//                 setState(() => _hasValue = v.isNotEmpty);
//                 widget.onChanged?.call(v);
//               },
//             ),
//           ),

//           // ───── Help / Error icon (always present) ─────
//           const SizedBox(width: GbInputGeometry.contentToInfoIconSpacing),
//           GbInputTokens.svgIcon(
//             assetPath: widget.state == GbInputState.error
//                 ? _errorIconAsset
//                 : _helpIconAsset,
//             size: GbInputGeometry.helpIconSize,
//             color: widget.state == GbInputState.error
//                 ? GbInputTokens.errorIconColor(context)
//                 : GbInputTokens.helpIconColor(context, intent),
//           ),

//           // ───── Spacing ─────
//           const SizedBox(width: GbInputGeometry.passwordToggleSpacing),

//           // ───── SHOW / HIDE toggle ─────
//           GestureDetector(
//             onTap: isDisabled
//                 ? null
//                 : () => setState(() => _obscured = !_obscured),
//             behavior: HitTestBehavior.opaque,
//             child: Container(
//               width: toggleWidth,
//               height: toggleHeight,
//               alignment: Alignment.center,
//               child: Text(
//                 _obscured ? 'SHOW' : 'HIDE',
//                 style: GbInputTokens.inputTextStyle(widget.size).copyWith(
//                   color: isDisabled
//                       ? SemanticColors.of(context).textDisabled
//                       : SemanticColors.of(context).text,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );

//     // ─────────────────────────────────────────────
//     // 5️⃣ Layout
//     // ─────────────────────────────────────────────
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.label != null) ...[
//           Text(widget.label!, style: GbInputTokens.labelTextStyle()),
//           const SizedBox(height: GbInputGeometry.labelToFieldSpacing),
//         ],
//         field,
//         if (widget.helperText != null) ...[
//           const SizedBox(height: GbInputGeometry.fieldToFooterSpacing),
//           Text(
//             widget.helperText!,
//             style: GbInputTokens.helperTextStyle().copyWith(
//               color: GbInputTokens.footerTextColor(context, intent),
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }
