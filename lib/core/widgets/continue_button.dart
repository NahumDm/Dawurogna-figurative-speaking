import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: SizedBox(
        width: double.infinity,
        child: Semantics(
          button: true,
          label: AppConstants.continueLabel,
          child: ElevatedButton(
            onPressed: onPressed,
            child: const Text(AppConstants.continueLabel),
          ),
        ),
      ),
    );
  }
}
