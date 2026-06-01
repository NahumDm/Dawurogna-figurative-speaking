import 'package:flutter/material.dart';

/// Brand colors exposed through [ThemeExtension] for light/dark parity.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brandRed,
    required this.brandGold,
    required this.culturalOverlay,
    required this.detailSectionDivider,
    required this.appBarTitleOnOverlay,
  });

  final Color brandRed;
  final Color brandGold;
  final Color culturalOverlay;
  final Color detailSectionDivider;

  /// App bar title on dark / image backgrounds (proverb detail).
  final Color appBarTitleOnOverlay;

  static const light = AppColors(
    brandRed: Color(0xFFDC2626),
    brandGold: Color(0xFFFBBF24),
    culturalOverlay: Color(0x99000000),
    detailSectionDivider: Color(0x33FFFFFF),
    appBarTitleOnOverlay: Color(0xFFFFFFFF),
  );

  static const dark = AppColors(
    brandRed: Color(0xFFEF4444),
    brandGold: Color(0xFFFBBF24),
    culturalOverlay: Color(0xCC000000),
    detailSectionDivider: Color(0x44FFFFFF),
    appBarTitleOnOverlay: Color(0xFFFFFFFF),
  );

  @override
  AppColors copyWith({
    Color? brandRed,
    Color? brandGold,
    Color? culturalOverlay,
    Color? detailSectionDivider,
    Color? appBarTitleOnOverlay,
  }) {
    return AppColors(
      brandRed: brandRed ?? this.brandRed,
      brandGold: brandGold ?? this.brandGold,
      culturalOverlay: culturalOverlay ?? this.culturalOverlay,
      detailSectionDivider:
          detailSectionDivider ?? this.detailSectionDivider,
      appBarTitleOnOverlay:
          appBarTitleOnOverlay ?? this.appBarTitleOnOverlay,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      brandRed: Color.lerp(brandRed, other.brandRed, t)!,
      brandGold: Color.lerp(brandGold, other.brandGold, t)!,
      culturalOverlay: Color.lerp(culturalOverlay, other.culturalOverlay, t)!,
      detailSectionDivider:
          Color.lerp(detailSectionDivider, other.detailSectionDivider, t)!,
      appBarTitleOnOverlay:
          Color.lerp(appBarTitleOnOverlay, other.appBarTitleOnOverlay, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
