import 'dart:async';

import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_theme.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/data/repositories/proverbs_repository.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/data/favorite_repository.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/favorites_controller.dart';
import 'package:dawurogna_figurative_speaking/features/proverb_detail/presentation/proverb_detail_screen.dart';
import 'package:dawurogna_figurative_speaking/features/proverbs/proverbs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class _DelayedProverbsRepository implements ProverbsRepository {
  final _items = [
    const Proverb(
      id: '99',
      letter: 'A',
      dawuro: 'loaded proverb',
      phonetic: 'loaded',
      amharic: 'loaded',
    ),
  ];

  bool _loaded = false;
  bool _isLoading = true;

  @override
  List<Proverb> get allProverbs => _loaded ? _items : const [];

  @override
  String? get errorMessage => null;

  @override
  bool get isLoading => _isLoading;

  @override
  Future<void> loadProverbs() async {
    if (_loaded) return;
    await Future<void>.delayed(const Duration(milliseconds: 50));
    _loaded = true;
    _isLoading = false;
  }

  @override
  List<Proverb> getProverbsByLetter(String letter) => allProverbs;

  @override
  int proverbCountForLetter(String letter) => allProverbs.length;

  @override
  Proverb? getProverbById(String id) {
    for (final item in allProverbs) {
      if (item.id == id) return item;
    }
    return null;
  }
}

class _NoopFavoriteRepository implements FavoriteRepository {
  @override
  Future<void> init() async {}

  @override
  Set<String> get favoriteIds => const {};

  @override
  bool isFavorite(String proverbId) => false;

  @override
  Future<bool> toggle(String proverbId) async => true;

  @override
  Future<void> remove(String proverbId) async {}
}

void main() {
  testWidgets('detail shows loading then content, not false not-found', (
    tester,
  ) async {
    final repository = _DelayedProverbsRepository();
    final controller = ProverbsController(repository);
    unawaited(controller.loadProverbs());

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ProverbsController>.value(value: controller),
          ChangeNotifierProvider<FavoritesController>(
            create: (_) => FavoritesController(
              favoriteRepository: _NoopFavoriteRepository(),
              proverbsRepository: repository,
            ),
          ),
        ],
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/tale/:id',
                builder: (context, state) => ProverbDetailScreen(
                  proverbId: state.pathParameters['id']!,
                ),
              ),
            ],
            initialLocation: '/tale/99',
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text(AppConstants.detailNotFoundMessage), findsNothing);

    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();

    expect(find.text('loaded proverb'), findsWidgets);
    expect(find.text(AppConstants.detailNotFoundMessage), findsNothing);

    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
