import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/constants/dawuro_alphabet.dart';
import 'package:dawurogna_figurative_speaking/core/router/route_names.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/dawuro_app_bar_title.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/staggered_entrance.dart';
import 'package:dawurogna_figurative_speaking/features/proverb_of_day/widgets/proverb_of_day_action.dart';
import 'package:dawurogna_figurative_speaking/features/proverbs/proverbs_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.contentMaxWidth(context);
    final padding = AppSpacing.screenPadding(context);
    final letters = DawuroAlphabet.letters;
    final controller = context.watch<ProverbsController>();

    return Scaffold(
      appBar: AppBar(
        title: const DawuroAppBarTitle(AppConstants.appTitle),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      padding.left,
                      AppSpacing.sm,
                      padding.right,
                      AppSpacing.md,
                    ),
                    child: _CategoryHeader(letterCount: letters.length),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: padding.left,
                      right: padding.right,
                      bottom: AppSpacing.sm,
                    ),
                    child: _QuickLetterRail(
                      letters: letters,
                      onLetterTap: (letter) => _openLetter(context, letter),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    padding.left,
                    0,
                    padding.right,
                    padding.bottom,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _AlphabetListGroup(
                      letters: letters,
                      controller: controller,
                      onLetterTap: (letter) => _openLetter(context, letter),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openLetter(BuildContext context, String letter) {
    context.pushNamed(
      RouteNames.eachAlphabetList,
      pathParameters: {'alphabet': letter},
    );
  }
}

/// Header — unchanged layout (user-approved).
class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.letterCount});

  final int letterCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final scheme = theme.colorScheme;

    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Container(height: 4, color: colors.brandRed)),
              Expanded(child: Container(height: 4, color: colors.brandGold)),
              Expanded(
                child: Container(height: 4, color: scheme.onSurface),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                _BrowseIcon(colors: colors),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.categoryBrowseTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        AppConstants.categoryBrowseSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        AppConstants.categoryAlphabetCountLabel(letterCount),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colors.brandRed,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.35)),
          const ProverbOfDayAction(),
        ],
      ),
    );
  }
}

class _BrowseIcon extends StatelessWidget {
  const _BrowseIcon({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: colors.brandGold.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.brandGold, width: 2),
      ),
      child: Icon(Icons.grid_view_rounded, color: colors.brandRed, size: 28),
    );
  }
}

/// Horizontal quick-jump chips (common in language / reading apps).
class _QuickLetterRail extends StatelessWidget {
  const _QuickLetterRail({
    required this.letters,
    required this.onLetterTap,
  });

  final List<String> letters;
  final ValueChanged<String> onLetterTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xs, bottom: AppSpacing.sm),
          child: Text(
            AppConstants.categoryQuickJumpLabel,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: scheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: letters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final letter = letters[index];
              return Material(
                color: colors.brandRed.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onLetterTap(letter),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 40),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: colors.brandRed,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Grouped list — dictionary-style rows inside one card.
class _AlphabetListGroup extends StatelessWidget {
  const _AlphabetListGroup({
    required this.letters,
    required this.controller,
    required this.onLetterTap,
  });

  final List<String> letters;
  final ProverbsController controller;
  final ValueChanged<String> onLetterTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List.generate(letters.length, (index) {
          final letter = letters[index];
          final count = controller.isLoading
              ? null
              : controller.getProverbsByLetter(letter).length;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StaggeredEntrance(
                index: index,
                child: _AlphabetListRow(
                  letter: letter,
                  proverbCount: count,
                  onTap: () => onLetterTap(letter),
                ),
              ),
              if (index < letters.length - 1)
                Divider(
                  height: 1,
                  indent: 72,
                  endIndent: AppSpacing.md,
                  color: scheme.outline.withValues(alpha: 0.2),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _AlphabetListRow extends StatelessWidget {
  const _AlphabetListRow({
    required this.letter,
    required this.proverbCount,
    required this.onTap,
  });

  final String letter;
  final int? proverbCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final scheme = theme.colorScheme;

    return Semantics(
      button: true,
      label: 'Proverbs starting with $letter',
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 12,
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colors.brandRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  letter,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.proverbListAppBarTitle(letter),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (proverbCount != null)
                      Text(
                        AppConstants.categoryLetterCountLabel(proverbCount!),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      )
                    else
                      SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.brandRed.withValues(alpha: 0.5),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
