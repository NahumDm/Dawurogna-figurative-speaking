import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ColorIndicator extends StatelessWidget {
  const ColorIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final width = MediaQuery.sizeOf(context).width * 0.8;
    final segmentWidth = width / 3;

    return SizedBox(
      width: width,
      child: Row(
        children: [
          _Bar(color: colors.brandRed, width: segmentWidth),
          _Bar(color: Theme.of(context).colorScheme.onSurface, width: segmentWidth),
          _Bar(color: colors.brandGold, width: segmentWidth),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.color, required this.width});

  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(height: 8, width: width, color: color);
  }
}
