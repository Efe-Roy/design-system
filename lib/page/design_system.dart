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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Typography Section
            // Text('Typography', style: textTheme.titleLarge),
            // const SizedBox(height: 8),
            // Text('Heading Large', style: textTheme.headlineLarge),
            // const SizedBox(height: 8.0),
            // Text('Heading Medium', style: textTheme.headlineMedium),
            // const SizedBox(height: 8.0),
            // Text('Title Large', style: textTheme.titleLarge),
            // const SizedBox(height: 8.0),
            // Text('Body Large', style: textTheme.bodyLarge),
            // const SizedBox(height: 8.0),
            // Text('Body Medium', style: textTheme.bodyMedium),
            // const SizedBox(height: 8.0),
            // Text('Label Large', style: textTheme.labelLarge),

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

            Row(
              children: [
                Icon(Icons.brightness_6, color: colors.colorAccent),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dark Mode'),
                      Text('Switch theme',
                          style: TextStyle(
                              fontSize: 12,
                              color: colors.colorTextSecondary)),
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
