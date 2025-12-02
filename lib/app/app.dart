// app/app.dart
import 'package:design_system/blocs/theme/app_theme.dart';
import 'package:design_system/blocs/theme/theme_cubit.dart';
import 'package:design_system/blocs/theme/theme_state.dart';
import 'package:design_system/page/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        // final colors = themeState.colors;

        final theme = buildThemeData(themeState.colors, themeState.isDark);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: DesignSystemPage(),
          routes: {
            '/design': (_) => const DesignSystemPage(),
          },
        );
      },
    );
  }
}
