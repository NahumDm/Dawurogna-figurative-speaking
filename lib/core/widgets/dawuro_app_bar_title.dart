import 'package:dawurogna_figurative_speaking/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Standard app bar title: Dash font, regular weight.
class DawuroAppBarTitle extends StatelessWidget {
  const DawuroAppBarTitle(
    this.text, {
    super.key,
    this.color,
  });

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolvedColor =
        color ??
        Theme.of(context).appBarTheme.titleTextStyle?.color ??
        Theme.of(context).colorScheme.onSurface;

    return Text(
      text,
      style: AppTheme.appBarTitleStyle(color: resolvedColor),
    );
  }
}
