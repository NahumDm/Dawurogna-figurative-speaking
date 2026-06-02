import 'package:dawurogna_figurative_speaking/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('theme controller persists dark mode preference', () async {
    SharedPreferences.setMockInitialValues({});

    final controller = ThemeController();
    await controller.loadFromStorage();
    expect(controller.themeMode, ThemeMode.light);

    await controller.setDarkMode(true);
    expect(controller.themeMode, ThemeMode.dark);

    final reloaded = ThemeController();
    await reloaded.loadFromStorage();
    expect(reloaded.themeMode, ThemeMode.dark);
  });
}
