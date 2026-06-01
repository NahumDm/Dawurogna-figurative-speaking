import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/router/route_names.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/color_indicator.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _BookImage(),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      AppConstants.onboardingTitle,
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md + 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      child: Text(
                        AppConstants.onboardingSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const ColorIndicator(),
              const SizedBox(height: AppSpacing.md),
              ContinueButton(
                onPressed: () => context.goNamed(RouteNames.category),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookImage extends StatelessWidget {
  const _BookImage();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          AppConstants.bookIconAsset,
          height: 80,
          width: 80,
          semanticLabel: 'Book icon',
        ),
      ),
    );
  }
}
