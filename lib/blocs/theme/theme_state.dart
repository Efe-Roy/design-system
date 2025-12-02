// core/blocs/theme/theme_state.dart


import 'package:design_system/blocs/theme/semantic_tokens.dart';

class ThemeState {
  final bool isDark;
  final SemanticColors colors;

  const ThemeState({
    required this.isDark,
    required this.colors,
  });

  factory ThemeState.light() => ThemeState(isDark: false, colors: SemanticColors.light());
  factory ThemeState.dark() => ThemeState(isDark: true, colors: SemanticColors.dark());
}
