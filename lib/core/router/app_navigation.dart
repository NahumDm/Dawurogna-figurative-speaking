import 'package:dawurogna_figurative_speaking/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralized GoRouter navigation (named routes only).
abstract final class AppNavigation {
  static void openOnboarding(BuildContext context) {
    context.goNamed(RouteNames.onboarding);
  }

  static void openCategory(BuildContext context) {
    context.goNamed(RouteNames.category);
  }

  static void openLetterList(BuildContext context, String letter) {
    context.pushNamed(
      RouteNames.eachAlphabetList,
      pathParameters: {'alphabet': letter},
    );
  }

  static void openProverbDetail(
    BuildContext context,
    String proverbId, {
    Offset slideFrom = const Offset(1, 0),
  }) {
    context.pushNamed(
      RouteNames.taleDetail,
      pathParameters: {'id': proverbId},
      extra: slideFrom,
    );
  }

  static void replaceProverbDetail(
    BuildContext context,
    String proverbId, {
    Offset slideFrom = const Offset(1, 0),
  }) {
    context.pushReplacementNamed(
      RouteNames.taleDetail,
      pathParameters: {'id': proverbId},
      extra: slideFrom,
    );
  }

  /// When detail is opened without back stack, return to letter list.
  static void goToLetterList(BuildContext context, String letter) {
    context.goNamed(
      RouteNames.eachAlphabetList,
      pathParameters: {'alphabet': letter},
    );
  }
}
