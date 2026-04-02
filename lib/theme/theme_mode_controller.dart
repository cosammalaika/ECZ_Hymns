import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController extends ValueNotifier<ThemeMode> {
  static const String _storageKey = 'theme_mode';

  ThemeModeController._(super.value);

  static Future<ThemeModeController> create() async {
    final SharedPreferences preferences =
        await SharedPreferences.getInstance();
    final String? storedMode = preferences.getString(_storageKey);

    return ThemeModeController._(_themeModeFromString(storedMode));
  }

  Future<void> setMode(ThemeMode themeMode) async {
    if (value == themeMode) {
      return;
    }

    value = themeMode;
    await _persist();
  }

  Future<void> _persist() async {
    final SharedPreferences preferences =
        await SharedPreferences.getInstance();
    await preferences.setString(_storageKey, value.name);
  }

  static ThemeMode _themeModeFromString(String? value) {
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}

class ThemeModeScope extends InheritedNotifier<ThemeModeController> {
  const ThemeModeScope({
    super.key,
    required ThemeModeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeModeController of(BuildContext context) {
    final ThemeModeScope? scope =
        context.dependOnInheritedWidgetOfExactType<ThemeModeScope>();
    assert(scope != null, 'ThemeModeScope is missing from the widget tree.');
    return scope!.notifier!;
  }
}
