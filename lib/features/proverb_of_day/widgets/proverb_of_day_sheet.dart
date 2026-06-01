import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/router/route_names.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/features/proverb_of_day/services/proverb_of_day_service.dart';
import 'package:dawurogna_figurative_speaking/features/proverbs/proverbs_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Bottom sheet that reveals today's proverb without cluttering the category list.
class ProverbOfDaySheet extends StatelessWidget {
  const ProverbOfDaySheet({super.key, required this.proverb});

  final Proverb proverb;

  static Future<void> show(BuildContext context) {
    final controller = context.read<ProverbsController>();
    if (controller.isLoading) {
      return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        builder: (context) => const Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final proverb = const ProverbOfDayService().selectForDate(
      controller.allProverbs,
    );
    if (proverb == null) return Future.value();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => ProverbOfDaySheet(proverb: proverb),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final scheme = theme.colorScheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.75;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.md + bottomInset,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _BrandStripe(colors: colors, scheme: scheme),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: colors.brandGold,
                    size: 22,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    AppConstants.proverbOfDayTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.brandRed,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                AppConstants.proverbOfDaySheetSubtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                proverb.dawuro,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                proverb.amharic,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
              SizedBox(height: AppSpacing.sectionGap(context)),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.pushNamed(
                    RouteNames.taleDetail,
                    pathParameters: {'id': proverb.id},
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colors.brandRed,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(AppConstants.proverbOfDayReadMore),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppConstants.proverbOfDayDismissLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandStripe extends StatelessWidget {
  const _BrandStripe({required this.colors, required this.scheme});

  final AppColors colors;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          Expanded(child: Container(height: 4, color: colors.brandRed)),
          Expanded(child: Container(height: 4, color: colors.brandGold)),
          Expanded(child: Container(height: 4, color: scheme.onSurface)),
        ],
      ),
    );
  }
}
