import 'package:design_system/blocs/theme/app_text_style.dart';
import 'package:design_system/blocs/theme/theme_cubit.dart';
import 'package:design_system/core/common/widget/custom_button.dart';
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

            // Filled button (default)
            CustomButton(
              text: "Submit",
              onPressed: () {},
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),

            // Outlined button
            CustomButton(
              text: "Cancel",
              onPressed: () {},
              backgroundColor: Colors.transparent, // For outlined buttons, background is transparent
              textColor: Colors.blue,
              isOutlined: true,
            ),

            // Outlined button with custom border color
            CustomButton(
              text: "Edit Profile",
              onPressed: () {},
              backgroundColor: Colors.transparent,
              textColor: Colors.purple,
              isOutlined: true,
              borderColor: Colors.purple,
            ),

            // Outlined button with icons
            CustomButton(
              text: "Export",
              onPressed: () {},
              backgroundColor: Colors.transparent,
              textColor: Colors.green,
              isOutlined: true,
              isFullWidth: false,
              iconBefore: Icon(Icons.circle_outlined, color: Colors.green),
              iconAfter: Icon(Icons.download, color: Colors.green),
              borderWidth: 2.0,
            ),

            // Thicker border
            CustomButton(
              text: "Delete",
              onPressed: () {},
              backgroundColor: Colors.transparent,
              textColor: Colors.red,
              isOutlined: true,
              borderColor: Colors.red,
              borderWidth: 2.0,
            ),

            // Using theme colors for outlined button
            CustomButton(
              text: "Learn More",
              onPressed: () {},
              backgroundColor: Colors.transparent,
              textColor: Theme.of(context).primaryColor,
              isOutlined: true,
              borderColor: Theme.of(context).primaryColor,
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
