import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';
import 'package:design_system/blocs/theme/gb_theme_cubit.dart';
import 'package:design_system/core/common/components/gb_input_dropdown/gb_input_dropdown.dart';
import 'package:design_system/core/common/components/gb_input_dropdown/gb_input_dropdown_types.dart';
import 'package:design_system/core/common/components/gb_avatar/gb_avatar.dart';
import 'package:design_system/core/common/components/gb_avatar/gb_avatar_types.dart';

class DesignSystemPage extends StatefulWidget {
  const DesignSystemPage({super.key});

  @override
  State<DesignSystemPage> createState() => _DesignSystemPageState();
}

class _DesignSystemPageState extends State<DesignSystemPage> {
  //  STATE
  String? _selectedSimple;
  String? _selectedCountry;
  String? _selectedIcon;
  String? _selectedAvatar;
  String? _selectedDot;

  //  MOCK DATA 1: Simple
  final List<GbInputDropdownItem<String>> _simpleItems = [
    const GbInputDropdownItem(
      value: 'daily',
      text: 'Daily Standup',
      supportingText: '10:00 AM',
    ),
    const GbInputDropdownItem(
      value: 'review',
      text: 'Design Review',
      supportingText: '2:00 PM',
    ),
    const GbInputDropdownItem(value: 'retro', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro1', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro2', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro3', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro4', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro5', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro6', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro7', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro8', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro9', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro10', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro11', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro12', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro13', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro14', text: 'Sprint Retrospective'),
    const GbInputDropdownItem(value: 'retro15', text: 'Sprint Retrospective'),
  ];

  //  MOCK DATA 2: Normal (With Country Flags) 🆕
  final List<GbInputDropdownItem<String>> _countryItems = [
    const GbInputDropdownItem(value: 'ng', text: 'Nigeria', countryCode: 'NG'),
    const GbInputDropdownItem(
      value: 'ng',
      text: 'United States',
      countryCode: 'NG',
    ),
    const GbInputDropdownItem(
      value: 'ng',
      text: 'United Kingdom',
      countryCode: 'NG',
    ),
    const GbInputDropdownItem(value: 'global', text: 'Global (No Flag)'),
  ];

  //  MOCK DATA 3: Icon Leading
  final List<GbInputDropdownItem<String>> _iconItems = [
    const GbInputDropdownItem(
      value: 'work',
      text: 'Work',
      leading: Icon(Icons.work_outline),
    ),
    const GbInputDropdownItem(
      value: 'home',
      text: 'Home',
      leading: Icon(Icons.home_outlined),
    ),
    const GbInputDropdownItem(
      value: 'travel',
      text: 'Travel',
      leading: Icon(Icons.flight),
    ), // Added icon back in
  ];

  //  MOCK DATA 4: Avatars
  final List<GbInputDropdownItem<String>> _avatarItems = [
    const GbInputDropdownItem(
      value: 'olivia',
      text: 'Olivia Rhye',
      supportingText: '@olivia',
      leading: GbAvatar(
        size: GbAvatarSize.xs,
        image: NetworkImage('https://i.pravatar.cc/150?u=olivia'),
        initials: 'OR',
      ),
    ),
    const GbInputDropdownItem(
      value: 'phoenix',
      text: 'Phoenix Baker',
      supportingText: '@phoenix',
      leading: GbAvatar(size: GbAvatarSize.xs, initials: 'PB'),
    ),
    const GbInputDropdownItem(
      value: 'guest',
      text: 'Guest User',
      supportingText: '(No Account)',
      leading: GbAvatar(size: GbAvatarSize.xs, placeholder: true),
    ),
  ];

  //  MOCK DATA 5: Dot Leading (Status)
  final List<GbInputDropdownItem<String>> _dotItems = [
    const GbInputDropdownItem(
      value: 'online',
      text: 'Online',
      dotColor: Colors.green,
    ),
    const GbInputDropdownItem(
      value: 'busy',
      text: 'Busy',
      dotColor: Colors.red,
    ),
    const GbInputDropdownItem(
      value: 'away',
      text: 'Away',
      dotColor: Colors.amber,
    ),
    const GbInputDropdownItem(
      value: 'offline',
      text: 'Offline',
      dotColor: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final colors = themeState.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: const Text("Dropdown Component Audit"),
        backgroundColor: colors.backgroundDarkBlue,
        iconTheme: IconThemeData(color: colors.text),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================================================
            //  TEST 1: Normal Type (Text Only)
            // ============================================================
            const _Header("1. Normal Type (Text Only)"),
            GbInputDropdown<String>(
              items: _simpleItems,
              value: _selectedSimple,
              label: "Meeting Type",
              hintText: "Standard dropdown without search",
              placeholder: "Select meeting",
              modalTitle: "Select Meeting",
              type: GbInputDropdownType.normal,
              size: GbInputDropdownSize.md,
              onChanged: (value) => setState(() => _selectedSimple = value),
            ),
            const SizedBox(height: 32),

            // ============================================================
            //  TEST 2: Normal Type (With Country Flags) 🆕
            // ============================================================
            const _Header("2. Normal Type (Country Flags)"),
            GbInputDropdown<String>(
              items: _countryItems,
              value: _selectedCountry,
              label: "Country",
              placeholder: "Select country",
              modalTitle: "Select Country",
              showSearch: true,
              type: GbInputDropdownType.normal,
              size: GbInputDropdownSize.md,
              onChanged: (value) => setState(() => _selectedCountry = value),
            ),
            const SizedBox(height: 32),

            // ============================================================
            //  TEST 3: Icon Leading
            // ============================================================
            const _Header("3. Icon Leading"),
            GbInputDropdown<String>(
              items: _iconItems,
              value: _selectedIcon,
              label: "Location",
              placeholder: "Select location",
              modalTitle: "Choose Location",
              type: GbInputDropdownType.iconLeading,
              size: GbInputDropdownSize.md,
              onChanged: (value) => setState(() => _selectedIcon = value),
            ),
            const SizedBox(height: 32),

            // ============================================================
            //  TEST 4: Avatar Leading (With Search)
            // ============================================================
            const _Header("4. Avatar Leading (Image/Initials/Placeholder)"),
            GbInputDropdown<String>(
              items: _avatarItems,
              value: _selectedAvatar,
              label: "Team Member",
              placeholder: "Select member",
              modalTitle: "Assign Member",
              showSearch: true,
              type: GbInputDropdownType.avatarLeading,
              size: GbInputDropdownSize.md,
              toolTip: "Select a user to see their avatar.",
              onChanged: (value) => setState(() => _selectedAvatar = value),
            ),
            const SizedBox(height: 32),

            // ============================================================
            //  TEST 5: Dot Leading (Status)
            // ============================================================
            const _Header("5. Dot Leading (Status)"),
            GbInputDropdown<String>(
              items: _dotItems,
              value: _selectedDot,
              label: "User Status",
              placeholder: "Select status",
              modalTitle: "Set Status",
              type: GbInputDropdownType.dotLeading,
              size: GbInputDropdownSize.md,
              onChanged: (value) => setState(() => _selectedDot = value),
            ),
            const SizedBox(height: 32),

            // ============================================================
            //  TEST 6: Disabled State
            // ============================================================
            const _Header("6. Disabled State"),
            GbInputDropdown<String>(
              items: _simpleItems,
              value: null,
              label: "Disabled Dropdown",
              placeholder: "Cannot select",
              enabled: false,
              type: GbInputDropdownType.normal,
              size: GbInputDropdownSize.md,
            ),

            const SizedBox(height: 40),

            // Theme Switcher...
            const _Header("Theme Settings"),
            Row(
              children: [
                Icon(Icons.brightness_6, color: colors.colorAccent),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dark Mode', style: GlobusTypography.textMdBold),
                      Text(
                        'Toggle application theme',
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

class _Header extends StatelessWidget {
  final String title;
  const _Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.grey,
        ),
      ),
    );
  }
}
