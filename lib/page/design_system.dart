import 'package:design_system/blocs/theme/app_text_style.dart';
import 'package:design_system/blocs/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesignSystemPage extends StatelessWidget {
  const DesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final colors = themeState.colors;
<<<<<<< HEAD
    //final textTheme = Theme.of(context).textTheme;
=======
>>>>>>> 56b25cea7976f76b26b9de21ba4c13a7cee7c242

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Typography Section
<<<<<<< HEAD
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
=======
            Text(
              'Welcome Back',
              style: AppTextStyles.headingLarge,
            ),
            SizedBox(height: 8),
            Text(
              'Sign in to continue',
              style: AppTextStyles.bodyMedium,
            ),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: AppTextStyles.labelSmall,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Sign In',
                style: AppTextStyles.buttonPrimary,
              ),
            ),
>>>>>>> 56b25cea7976f76b26b9de21ba4c13a7cee7c242

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
