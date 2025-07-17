import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';

class ColorIndicator extends StatelessWidget {
  const ColorIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Constants.containerHeight,
            width: Constants.containerWidth,
            color: Constants.butttonColor,
          ),
          Container(
            height: Constants.containerHeight,
            width: Constants.containerWidth,
            color: Constants.textColor,
          ),
          Container(
            height: Constants.containerHeight,
            width: Constants.containerWidth,
            color: Constants.iconColor,
          ),
        ],
      ),
    );
  }
}
