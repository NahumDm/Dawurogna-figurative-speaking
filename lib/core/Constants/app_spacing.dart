import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:flutter/material.dart';

/// Consistent spacing scale used across screens.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static EdgeInsets screenPadding(BuildContext context) {
    final horizontal = Responsive.horizontalPadding(context);
    return EdgeInsets.fromLTRB(horizontal, md, horizontal, lg);
  }

  static double sectionGap(BuildContext context) {
    return Responsive.isTabletOrLarger(context) ? lg : md;
  }
}
