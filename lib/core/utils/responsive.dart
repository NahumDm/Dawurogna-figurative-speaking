import 'package:flutter/material.dart';

enum ScreenSizeClass { compact, medium, expanded }

abstract final class Responsive {
  static const double compactWidth = 360;
  static const double tabletWidth = 600;
  static const double expandedWidth = 840;

  static ScreenSizeClass sizeClassOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= expandedWidth) return ScreenSizeClass.expanded;
    if (width >= tabletWidth) return ScreenSizeClass.medium;
    return ScreenSizeClass.compact;
  }

  static bool isCompact(BuildContext context) =>
      sizeClassOf(context) == ScreenSizeClass.compact;

  static bool isTabletOrLarger(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletWidth;

  static int gridColumnCount(BuildContext context) {
    return switch (sizeClassOf(context)) {
      ScreenSizeClass.compact => 1,
      ScreenSizeClass.medium => 2,
      ScreenSizeClass.expanded => 3,
    };
  }

  static double horizontalPadding(BuildContext context) {
    return switch (sizeClassOf(context)) {
      ScreenSizeClass.compact => 16,
      ScreenSizeClass.medium => 24,
      ScreenSizeClass.expanded => 32,
    };
  }

  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= expandedWidth) return 720;
    if (width >= tabletWidth) return 600;
    return width;
  }
}
