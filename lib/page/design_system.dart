import 'package:design_system/blocs/theme/gb_text_style.dart';
import 'package:design_system/blocs/theme/gb_theme_cubit.dart';
import 'package:design_system/core/common/components/gb_button/gb_button.dart';
import 'package:design_system/core/common/components/gb_button/gb_button_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesignSystemPage extends StatelessWidget {
  const DesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final colors = themeState.colors;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Typography Section
            Text('Typography', style: GlobusTypography.display2xlBold),
            const SizedBox(height: 8.0),
            Text('Heading Large', style: GlobusTypography.displayXlBold),
            const SizedBox(height: 8.0),
            Text('Heading Medium', style: GlobusTypography.displayLgBold),
            const SizedBox(height: 8.0),
            Text('Title Large', style: GlobusTypography.displayMdBold),
            const SizedBox(height: 8.0),
            Text('Body Large', style: GlobusTypography.displaySmBold),
            const SizedBox(height: 8.0),
            Text('Body Medium', style: GlobusTypography.displayXsBold),
            const SizedBox(height: 8.0),
            Text('Label Large', style: GlobusTypography.displayXlBold),

            SizedBox(height: 16),

            Column(
              children: [
                GbButton(label: 'Small Button', size: sm, onPressed: () {}),
                SizedBox(height: 16), // Add space between buttons
                GbButton(
                  label: 'Large Button',
                  size: xxl,
                  hierarchy: tertiaryGray,
                  isFullWidth: true,
                  onPressed: () {},
                ),

                SizedBox(height: 16),

                GbButton(
                  label: 'Large Button',
                  size: xxl,
                  hierarchy: secondaryGray,
                  isFullWidth: true,
                  state: pressed,
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                GbButton(
                  label: 'Cancel',
                  hierarchy: secondaryGray,
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                GbButton(
                  label: 'Learn more',
                  hierarchy: tertiaryColor,
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                GbButton(
                  label: 'Forgot password?',
                  hierarchy: linkColor,
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                GbButton(
                  label: 'Delete account',
                  destructive: true,
                  hierarchy: primary,
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                GbButton(label: 'Continue', state: disabled, onPressed: () {}),
                SizedBox(height: 16),
                GbButton(label: 'Submitting', state: loading, onPressed: () {}),
              ],
            ),

            Row(
              children: [
                Icon(Icons.brightness_6, color: colors.colorAccent),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dark Mode'),
                      Text(
                        'Switch theme',
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.colorTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: themeState.isDark,
                  onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
