import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';

class DetailContainer extends StatelessWidget {
  const DetailContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      color: Constants.background,
      height: size.height * 0.8,
      width: size.width * 0.95,

      child: Opacity(
        opacity: 0.6,
        child: Image.asset(
          fit: BoxFit.fill,
          // height: Constants.imageHeight,
          // width: Constants.imageWidth,
          'assets/images/dawuro_gihibli.png',
        ),
      ),
    );
  }
}
