import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/router/route_names.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/dawuro_app_bar_title.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/empty_state_view.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/error_state_view.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/loading_view.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/features/proverbs/proverbs_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProverbListScreen extends StatelessWidget {
  const ProverbListScreen({super.key, required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProverbsController>();
    final proverbs = controller.getProverbsByLetter(letter);
    final maxWidth = Responsive.contentMaxWidth(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 20),
          tooltip: 'Back',
        ),
        title: DawuroAppBarTitle(AppConstants.proverbListAppBarTitle(letter)),
      ),
      body: SafeArea(
        child: _buildBody(context, controller, proverbs, maxWidth),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ProverbsController controller,
    List<Proverb> proverbs,
    double maxWidth,
  ) {
    if (controller.isLoading) {
      return const LoadingView(message: AppConstants.proverbListLoadingMessage);
    }

    if (controller.errorMessage != null) {
      return ErrorStateView(
        message: controller.errorMessage!,
        onRetry: () => controller.loadProverbs(),
      );
    }

    if (proverbs.isEmpty) {
      return const EmptyStateView(
        message: AppConstants.proverbListEmptyMessage,
        icon: Icons.menu_book_outlined,
      );
    }

    final padding = AppSpacing.screenPadding(context);
    final listGap = Responsive.isTabletOrLarger(context) ? 12.0 : 10.0;

    return Align(
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
                child: _LetterHeader(
                  letter: letter,
                  count: proverbs.length,
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
              sliver: SliverList.separated(
                itemCount: proverbs.length,
                separatorBuilder: (_, _) => SizedBox(height: listGap),
                itemBuilder: (context, index) {
                  final proverb = proverbs[index];
                  return _ProverbCard(
                    index: index + 1,
                    proverb: proverb,
                    onTap: () => context.pushNamed(
                      RouteNames.taleDetail,
                      pathParameters: {'id': proverb.id},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hero strip: letter badge + count, using brand red & gold.
class _LetterHeader extends StatelessWidget {
  const _LetterHeader({required this.letter, required this.count});

  final String letter;
  final int count;

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
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _LetterBadge(letter: letter),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.proverbListAppBarTitle(letter),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        AppConstants.proverbListCountLabel(count),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        AppConstants.proverbListTapHint,
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
        ],
      ),
    );
  }
}

class _LetterBadge extends StatelessWidget {
  const _LetterBadge({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: colors.brandRed,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colors.brandRed.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1,
        ),
      ),
    );
  }
}

class _ProverbCard extends StatelessWidget {
  const _ProverbCard({
    required this.index,
    required this.proverb,
    required this.onTap,
  });

  final int index;
  final Proverb proverb;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final scheme = theme.colorScheme;
    final useGoldAccent = index.isEven;

    return Semantics(
      button: true,
      label: proverb.dawuro,
      child: Material(
        color: scheme.surfaceContainerLow,
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 5,
                  color: useGoldAccent ? colors.brandGold : colors.brandRed,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpacing.sm,
                    top: AppSpacing.md,
                    bottom: AppSpacing.md,
                  ),
                  child: SizedBox(
                    width: 28,
                    child: Text(
                      '$index',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    child: Text(
                      proverb.dawuro,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: scheme.onSurface,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: colors.brandRed.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
