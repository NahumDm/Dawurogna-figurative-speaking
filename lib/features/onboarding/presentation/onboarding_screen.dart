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
    final horizontal = Responsive.horizontalPadding(context);
    final compact = Responsive.isCompact(context);
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    // 8dp rhythm: md (16) between copy blocks, lg/xl (24–32) between sections,
    // larger break before actions so description is not crowded against the bar.
    final gapAfterImage = compact ? AppSpacing.lg : AppSpacing.xl;
    final gapAfterTitle = AppSpacing.md;
    final gapAfterDescription =
        compact ? AppSpacing.xl * 4 + AppSpacing.lg : AppSpacing.xl * 5;
    final gapAfterColorBar = AppSpacing.md;
    final topInset = AppSpacing.lg;
    final bottomInset = AppSpacing.xl + AppSpacing.lg + safeBottom;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final minContentHeight =
                constraints.maxHeight - topInset - bottomInset;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontal,
                topInset,
                horizontal,
                bottomInset,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minContentHeight),
                child: Align(
                  alignment: const Alignment(0, -0.06),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Responsive.contentMaxWidth(context),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _BookImage(compact: compact),
                        SizedBox(height: gapAfterImage),
                        Text(
                          AppConstants.onboardingTitle,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: gapAfterTitle),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                          ),
                          child: Text(
                            AppConstants.onboardingSubtitle,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.5,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: gapAfterDescription),
                        const ColorIndicator(),
                        SizedBox(height: gapAfterColorBar),
                        ContinueButton(
                          onPressed: () => context.goNamed(RouteNames.category),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BookImage extends StatelessWidget {
  const _BookImage({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 88.0 : 104.0;

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Image.asset(
          AppConstants.bookIconAsset,
          height: size,
          width: size,
          fit: BoxFit.contain,
          semanticLabel: 'Book icon',
        ),
      ),
    );
  }
}
