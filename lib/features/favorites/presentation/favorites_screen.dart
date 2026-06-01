import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/router/route_names.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/dawuro_app_bar_title.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/loading_view.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/favorites_controller.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/widgets/favorite_proverb_card.dart';
import 'package:dawurogna_figurative_speaking/features/proverbs/proverbs_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesController>();
    final proverbs = context.watch<ProverbsController>();
    final maxWidth = Responsive.contentMaxWidth(context);
    final padding = AppSpacing.screenPadding(context);
    final listGap = Responsive.isTabletOrLarger(context) ? 12.0 : 10.0;

    return Scaffold(
      appBar: AppBar(
        title: const DawuroAppBarTitle(AppConstants.favoritesScreenTitle),
      ),
      body: SafeArea(
        child: proverbs.isLoading
            ? const LoadingView(message: AppConstants.proverbListLoadingMessage)
            : Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          padding.left,
                          AppSpacing.sm,
                          padding.right,
                          AppSpacing.sm,
                        ),
                        child: SearchBar(
                          controller: _searchController,
                          hintText: AppConstants.favoritesSearchHint,
                          leading: const Icon(Icons.search),
                          onChanged: favorites.updateSearch,
                          trailing: favorites.searchQuery.isEmpty
                              ? null
                              : [
                                  IconButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      favorites.clearSearch();
                                    },
                                    icon: const Icon(Icons.clear),
                                    tooltip: 'Clear search',
                                  ),
                                ],
                        ),
                      ),
                      Expanded(
                        child: favorites.favoriteProverbs.isEmpty
                            ? _FavoritesEmptyState(
                                hasFavorites: favorites.favoriteCount > 0,
                              )
                            : ListView.separated(
                                padding: EdgeInsets.fromLTRB(
                                  padding.left,
                                  AppSpacing.sm,
                                  padding.right,
                                  padding.bottom,
                                ),
                                itemCount: favorites.favoriteProverbs.length,
                                separatorBuilder: (_, _) =>
                                    SizedBox(height: listGap),
                                itemBuilder: (context, index) {
                                  final proverb =
                                      favorites.favoriteProverbs[index];
                                  return FavoriteProverbCard(
                                    proverb: proverb,
                                    onTap: () => context.pushNamed(
                                      RouteNames.taleDetail,
                                      pathParameters: {'id': proverb.id},
                                    ),
                                    onRemove: () =>
                                        favorites.removeFavorite(proverb.id),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _FavoritesEmptyState extends StatelessWidget {
  const _FavoritesEmptyState({required this.hasFavorites});

  final bool hasFavorites;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final scheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasFavorites ? Icons.search_off_rounded : Icons.star_outline,
              size: 64,
              color: colors.brandGold.withValues(alpha: 0.9),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              hasFavorites
                  ? 'No matches found'
                  : AppConstants.favoritesEmptyTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              hasFavorites
                  ? 'Try a different search term.'
                  : AppConstants.favoritesEmptyMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
