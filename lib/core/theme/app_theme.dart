import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const String _dashFont = 'Dash';
  static const String _robotoFont = 'Roboto';
  static const String _openSansFont = 'OpenSans';
  static const double appBarTitleFontSize = 18;

  /// Dash app bar titles — regular weight (not bold).
  static TextStyle appBarTitleStyle({required Color color}) {
    return TextStyle(
      fontFamily: _dashFont,
      fontSize: appBarTitleFontSize,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final appColors = isLight ? AppColors.light : AppColors.dark;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: appColors.brandRed,
      brightness: brightness,
      primary: appColors.brandRed,
      secondary: appColors.brandGold,
      surface: isLight ? const Color(0xFFF9FAFB) : const Color(0xFF121212),
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      extensions: [appColors],
      fontFamily: _openSansFont,
    );

    return base.copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: appBarTitleStyle(color: colorScheme.onSurface),
      ),
      textTheme: _textTheme(base.textTheme, colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.brandRed,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size(64, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontFamily: _robotoFont,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.onSurface,
        textColor: colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withValues(alpha: 0.35),
        thickness: 0.3,
        space: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: colorScheme.surfaceContainerHighest,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static TextTheme _textTheme(TextTheme base, ColorScheme scheme) {
    return base.copyWith(
      headlineMedium: base.headlineMedium?.copyWith(
        fontFamily: _dashFont,
        fontWeight: FontWeight.bold,
        color: scheme.onSurface,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: _robotoFont,
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontFamily: _openSansFont,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontFamily: _openSansFont,
        height: 1.55,
        color: scheme.onSurface,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontFamily: _openSansFont,
        height: 1.5,
        color: scheme.onSurfaceVariant,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontFamily: _openSansFont,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: scheme.onSurfaceVariant,
      ),
    );
  }
}
