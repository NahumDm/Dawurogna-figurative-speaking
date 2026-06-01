import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width * 0.8,
      child: Semantics(
        button: true,
        label: AppConstants.continueLabel,
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text(AppConstants.continueLabel),
        ),
      ),
    );
  }
}
