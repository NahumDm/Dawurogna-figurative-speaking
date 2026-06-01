import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and exposes the app [ThemeMode] (light / dark).
class ThemeController extends ChangeNotifier {
  static const _prefsKey = 'app_theme_mode';

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_prefsKey);
    _themeMode = stored == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> setDarkMode(bool enabled) async {
    final next = enabled ? ThemeMode.dark : ThemeMode.light;
    if (_themeMode == next) return;

    _themeMode = next;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, enabled ? 'dark' : 'light');
  }
}
