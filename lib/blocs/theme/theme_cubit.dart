// core/blocs/theme/theme_cubit.dart
import 'package:design_system/util/auth_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDark = AuthManager.getDarkMode();
    emit(isDark ? ThemeState.dark() : ThemeState.light());
  }

  Future<void> toggleTheme() async {
    final isCurrentlyDark = state.isDark;
    AuthManager.setDarkMode(!isCurrentlyDark);
    emit(!isCurrentlyDark ? ThemeState.dark() : ThemeState.light());
  }
}
