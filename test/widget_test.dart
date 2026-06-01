import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/router/app_router.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_theme.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/app_bottom_navigation.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/continue_button.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/data/repositories/proverbs_repository.dart';
import 'package:dawurogna_figurative_speaking/core/theme/theme_controller.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/data/favorite_repository.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/favorites_controller.dart';
import 'package:dawurogna_figurative_speaking/features/proverbs/proverbs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeProverbsRepository implements ProverbsRepository {
  final List<Proverb> _items = [
    const Proverb(
      id: '1',
      letter: 'A',
      dawuro: 'ምሳሌ አንድ',
      phonetic: 'msl 1',
      amharic: 'Example 1',
    ),
  ];

  @override
  List<Proverb> get allProverbs => _items;

  @override
  String? get errorMessage => null;

  @override
  bool get isLoading => false;

  @override
  Future<void> loadProverbs() async {}

  @override
  List<Proverb> getProverbsByLetter(String letter) {
    return _items
        .where(
          (p) => p.letter.trim().toUpperCase() == letter.trim().toUpperCase(),
        )
        .toList();
  }

  @override
  Proverb? getProverbById(String id) {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }
}

class _InMemoryFavoriteRepository implements FavoriteRepository {
  final Set<String> _ids = {};

  @override
  Future<void> init() async {}

  @override
  Set<String> get favoriteIds => Set.unmodifiable(_ids);

  @override
  bool isFavorite(String proverbId) => _ids.contains(proverbId);

  @override
  Future<bool> toggle(String proverbId) async {
    if (_ids.contains(proverbId)) {
      _ids.remove(proverbId);
      return false;
    }
    _ids.add(proverbId);
    return true;
  }

  @override
  Future<void> remove(String proverbId) async {
    _ids.remove(proverbId);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('App navigation smoke tests', () {
    testWidgets('Onboarding navigates to category list', (tester) async {
      final themeController = ThemeController();
      await themeController.loadFromStorage();
      final proverbsRepository = _FakeProverbsRepository();
      final favoriteRepository = _InMemoryFavoriteRepository();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeController>.value(
              value: themeController,
            ),
            ChangeNotifierProvider<ProverbsController>(
              create: (_) => ProverbsController(proverbsRepository),
            ),
            ChangeNotifierProvider<FavoritesController>(
              create: (_) => FavoritesController(
                favoriteRepository: favoriteRepository,
                proverbsRepository: proverbsRepository,
              ),
            ),
          ],
          child: MaterialApp.router(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.themeMode,
            routerConfig: appRouter,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text(AppConstants.onboardingTitle), findsOneWidget);

      await tester.tap(find.byType(ContinueButton));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('A'), findsWidgets);

      await tester.tap(find.text('A').last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('ምሳሌ አንድ'), findsWidgets);
    });

    testWidgets('Bottom navigation uses compact About label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: MediaQuery(
            data: const MediaQueryData(size: Size(350, 800)),
            child: Scaffold(
              body: AppBottomNavigation(
                onTabChange: (_) {},
                selectedTabIndex: 0,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(AppConstants.favoritesTabLabelCompact), findsWidgets);
      expect(find.text(AppConstants.aboutTabLabel), findsWidgets);
    });
  });
}
