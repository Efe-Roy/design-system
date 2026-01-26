import 'package:design_system/blocs/theme/gb_text_style.dart';
import 'package:design_system/blocs/theme/gb_theme_cubit.dart';
import 'package:design_system/core/common/components/gb_button/gb_button.dart';
//import 'package:design_system/core/common/components/gb_button/gb_button_colors.dart';
//import 'package:design_system/core/common/components/gb_button/gb_button_size.dart';
import 'package:design_system/core/common/components/gb_button/gb_button_aliases.dart'
    as button;
//import 'package:design_system/core/common/components/gb_button/gb_button_types.dart';
//import 'package:design_system/core/common/components/gb_button/gb_button_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/core/common/components/gb_avatar/gb_avatar.dart';
import 'package:design_system/core/common/components/gb_avatar/gb_avatar_types.dart';
import 'package:design_system/core/common/components/gb_avatar/gb_avatar_aliases.dart'
    as avatar;
import 'package:design_system/core/common/components/gb_input/gb_input_widget.dart';
import 'package:design_system/core/common/components/gb_input/gb_input_types.dart';

import 'package:flutter_svg/flutter_svg.dart';

class DesignSystemPage extends StatelessWidget {
  const DesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    //used to test input field with counter
    //final countController = TextEditingController(text: '1');
    //used to test input field with leadingText prefix
    //final leadingTextController = TextEditingController();
    //final leadingTextFocusNode = FocusNode()..requestFocus();

    //used to test input field with leadingText
    // final _leadingTextController = TextEditingController();
    // final _leadingTextErrorController = TextEditingController(text: '');
    // final _leadingTextDisabledController = TextEditingController(
    //   text: 'globusbank.com',
    // );

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
                GbButton(
                  label: 'Small Button',
                  size: button.sm,
                  onPressed: () {},
                ),
                SizedBox(height: 16), // Add space between buttons
                GbButton(
                  label: 'Large Button',
                  size: button.xl,
                  hierarchy: button.tertiaryGray,
                  isFullWidth: true,
                  onPressed: () {},
                ),
                SizedBox(height: 16),
              ],
            ),

            SizedBox(height: 16),

            //GbAvatar(
            //size: avatar.md,
            //image: NetworkImage('https://i.pravatar.cc/300'),
            //badge: avatar.company,
            //),
            SizedBox(height: 16),
            GbAvatar(
              size: avatar.md,
              initials: 'NP',
              color: GbAvatarColor.yellow,
              //badge: GbAvatarBadge.company,
              badge: avatar.company,
            ),

            SizedBox(height: 32),

            GbInputField(
              size: GbInputSize.sm,
              kind: GbInputType.trailingButton,
              destructive: false,
              state: GbInputState.active,
              hintText: 'Enter value',
              trailingIcon: SvgPicture.asset('assets/icons/copy.svg'),
              onTrailingIconPressed: () {
                debugPrint('Pressed');
              },
            ),

            SizedBox(height: 16),
            GbInputField(
              size: GbInputSize.md,
              kind: GbInputType.leadingText,
              destructive: true,
              state: GbInputState.active,
              label: 'leadingText',
              leadingText: 'www:',
              helperText: 'Focused state',
              controller: TextEditingController(),
            ),

            // GbInputField(
            //   size: GbInputSize.md,
            //   kind: GbInputType.leadingText,
            //   enabled: false, // 🚫 disabled
            //   destructive: false,
            //   label: 'leadingText',
            //   hintText: 'example.com',
            //   helperText: 'Enter your leadingText',
            //   controller: TextEditingController(text: 'www.globusbank.com'),
            // ),
            SizedBox(height: 16),

            // GbInputField(
            //   size: GbInputSize.md,
            //   kind: GbInputType.count,
            //   label: 'Quantity (Error)',
            //   hintText: '0',
            //   controller: TextEditingController(text: '0'),
            //   destructive: true,
            //   helperText: 'Quantity is required',
            // ),

            // GbAvatar(
            //   size: avatar.md,
            //   initials: 'NB',
            //   color: avatar.green,
            //   badge: avatar.company,
            // ),
            SizedBox(height: 32),
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
