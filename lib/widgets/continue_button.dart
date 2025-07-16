import 'package:dawurogna_figurative_speaking/constants/constants.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.elevatedButtonHeight,
      width: size.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Constants.butttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Continue',
          style: TextStyle(
            color: Constants.background,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: Constants.lgFont,
          ),
        ),
      ),
    );
  }
}
