import 'package:design_system/core/common/components/gb_tab/gb_tab.dart';
import 'package:design_system/core/common/components/gb_tooltip/gb_tooltip.dart';
import 'package:design_system/core/common/constants/gb_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/blocs/theme/gb_theme_cubit.dart';

class DesignSystemPage extends StatefulWidget {
  const DesignSystemPage({super.key});

  @override
  State<DesignSystemPage> createState() => _DesignSystemPageState();
}

class _DesignSystemPageState extends State<DesignSystemPage> {
  // State variables for the tab test cases
  int _standardTabIndex = 0;
  int _underlineTabIndex = 0;
  int _scrollableTabIndex = 0;
  int _whiteBorderTabIndex = 0;
  int _whiteRoundedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final colors = themeState.colors;

    return Scaffold(
      backgroundColor: colors.surfaceBold,
      appBar: AppBar(
        title: Text("Design System Audit", style: GlobusTypography.textLgBold),
        backgroundColor: colors.surfaceBold,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.text),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─────────────────────────────────────────────────────────────
            // 🧪 TABS SECTION
            // ─────────────────────────────────────────────────────────────
            _Header("1. Standard Buttons (Primary/Gray)"),
            GbTab(
              labels: const [
                "Primary",
                "Gray",
                "Disabled",
                // "With Badge",
                // "Long Label",
              ],
              fillWidth: true,
              type: GbTabType.buttonPrimary,
              selectedIndex: _standardTabIndex,
              onTabChanged: (index) =>
                  setState(() => _standardTabIndex = index),
            ),

            const SizedBox(height: 32),

            _Header("2. Underline Tabs (Track Line Check)"),
            GbTab(
              labels: const ["My Details", "Profile", "Password", "Team"],
              type: GbTabType.underline,
              selectedIndex: _underlineTabIndex,
              onTabChanged: (index) =>
                  setState(() => _underlineTabIndex = index),
            ),

            const SizedBox(height: 32),

            _Header("3. Scrollable + Smart Badges"),
            GbTab(
              labels: const [
                "Profile",
                "Profile",
                "Settings",
                "Logs",
                "Audit",
                "Profile",
              ],
              type: GbTabType.underlineFilled,
              selectedIndex: _scrollableTabIndex,
              onTabChanged: (index) =>
                  setState(() => _scrollableTabIndex = index),
              badgeLabels: const ["2", "5", null, null, "New", null],
            ),

            const SizedBox(height: 32),

            _Header("4. Button White Border (Rectangular)"),
            GbTab(
              fillWidth: false,
              labels: const [
                "Profile",
                "Password",
                "Profile",
                "Team",
                "Settings",
              ],
              size: GbTabSize.md,
              type: GbTabType.buttonWhiteBorder,
              selectedIndex: _whiteBorderTabIndex,
              onTabChanged: (index) =>
                  setState(() => _whiteBorderTabIndex = index),
            ),

            _Header("5. Button White Rounded (Pill)"),
            GbTab(
              labels: const [
                "My Details",
                "Profile",
                // "Password",
                // "Team",
                // "Settings",
              ],
              fillWidth: true,
              size: GbTabSize.md,
              type: GbTabType.roundedButtonWhiteBorder,
              selectedIndex: _whiteRoundedTabIndex,
              onTabChanged: (index) =>
                  setState(() => _whiteRoundedTabIndex = index),
            ),

            const SizedBox(height: 40),
            Divider(color: colors.borderSubtler),
            const SizedBox(height: 20),

            // ─────────────────────────────────────────────────────────────
            // 🧪 TOOLTIP SECTION (NEW)
            // ─────────────────────────────────────────────────────────────
            _Header("6. Tooltips (Visual Check)"),

            // A. Label Only
            const Text(
              "Label Only (Bottom Center Arrow):",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            const Center(
              child: GbTooltip(
                label: "This is a tooltip",
                arrow: Arrow.bottomLeft,
              ),
            ),

            const SizedBox(height: 32),

            // B. Label + Supporting Text
            const Text(
              "With Supporting Text (Top Center Arrow):",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            const Center(
              child: GbTooltip(
                label: "This is a tooltip",
                supportingText:
                    "Tooltips are used to describe or identify an element. In most scenarios, tooltips help the user understand meaning.",
                arrow: Arrow.topCenter,
              ),
            ),

            const SizedBox(height: 32),

            // C. Different Arrows
            const Text(
              "Arrow Variations:",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: const [
                GbTooltip(label: "Left Arrow", arrow: Arrow.left),
                GbTooltip(label: "Right Arrow", arrow: Arrow.right),
                GbTooltip(label: "Btm Left", arrow: Arrow.bottomLeft),
                GbTooltip(label: "Btm Right", arrow: Arrow.bottomRight),
              ],
            ),
            const SizedBox(height: 40),

            // ─────────────────────────────────────────────────────────────
            // 🎨 THEME SWITCHER
            // ─────────────────────────────────────────────────────────────
            _Header("Theme Settings"),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderSubtler),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.brightness_6, color: colors.text),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dark Mode',
                          style: GlobusTypography.textMdBold.copyWith(
                            color: colors.text,
                          ),
                        ),
                        Text(
                          'Check components in dark mode',
                          style: GlobusTypography.textSmRegular.copyWith(
                            color: colors.text,
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
      padding: const EdgeInsets.only(bottom: 16),
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
