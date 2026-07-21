import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ColorIndicator extends StatelessWidget {
  const ColorIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(child: _Bar(color: colors.brandRed)),
            Expanded(child: _Bar(color: Theme.of(context).colorScheme.onSurface)),
            Expanded(child: _Bar(color: colors.brandGold)),
          ],
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(height: 8, color: color);
  }
}
