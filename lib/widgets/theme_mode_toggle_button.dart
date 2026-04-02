import 'package:flutter/material.dart';

import '../theme/theme_mode_controller.dart';

class ThemeModeToggleButton extends StatelessWidget {
  const ThemeModeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeModeController controller = ThemeModeScope.of(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      onPressed: () {
        controller.setMode(isDark ? ThemeMode.light : ThemeMode.dark);
      },
      icon: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
      ),
    );
  }
}
