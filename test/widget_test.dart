// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:dawurogna_figurative_speaking/Core/Route/route_config.dart';
import 'package:dawurogna_figurative_speaking/widgets/continue_button.dart';
import 'package:dawurogna_figurative_speaking/Widgets/bottom_navigation.dart'
    as bn;
import 'package:dawurogna_figurative_speaking/Model/model.dart';

/// Test-only fake provider to avoid asset loading in widget tests.
class TestProverbsProvider extends ChangeNotifier {
  final List<ProverbModel> _items = [
    ProverbModel(
      id: 1,
      alphabet: 'A',
      dawurogna: 'ምሳሌ አንድ',
      amharicTranslation: 'Example 1',
      dawurognaPhonetic: 'msl 1',
    ),
    // add more sample items if you want
  ];

  bool _isLoading = false;

  List<ProverbModel> get allProverbs => _items;
  bool get isLoading => _isLoading;

  Future<void> loadProverbs() async {
    _isLoading = true;
    notifyListeners();
    // mimic a small async delay
    await Future<void>.delayed(const Duration(milliseconds: 10));
    _isLoading = false;
    notifyListeners();
  }

  List<ProverbModel> getProverbsByAlphabet(String alphabet) {
    return _items
        .where(
          (p) =>
              p.alphabet.trim().toUpperCase() == alphabet.trim().toUpperCase(),
        )
        .toList();
  }

  ProverbModel getProverbById(int id) {
    return _items.firstWhere((p) => p.id == id, orElse: () => _items.first);
  }
}

/// App-level smoke tests that avoid the UpgradeAlert (network/timers) by
/// constructing the app tree directly for testing.

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('App navigation & data smoke tests (with test provider)', () {
    testWidgets('Onboarding -> Category list loads (smoke)', (
      WidgetTester tester,
    ) async {
      // Build the app tree but use TestProverbsProvider to avoid asset loading/network
      await tester.pumpWidget(
        ChangeNotifierProvider<TestProverbsProvider>(
          create: (_) => TestProverbsProvider()..loadProverbs(),
          // routeProvider uses GoRouter and your real routes; it will read provider via context
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routeProvider,
          ),
        ),
      );

      // Wait for microtasks and navigation to settle
      await tester.pumpAndSettle();

      // Verify onboarding title exists.
      expect(find.text('ዳውሮኛ ተረትና ምሳሌ'), findsOneWidget);

      // Tap the Continue button (found by type)
      final continueButton = find.byType(ContinueButton);
      expect(continueButton, findsOneWidget);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      // In category screen, the list of alphabet tiles is shown (ListTile)
      final listTiles = find.byType(ListTile);
      expect(listTiles, findsAtLeastNWidgets(1));

      // Tap the first tile and check we navigated to a list/detail view using our sample data
      await tester.tap(listTiles.first);
      await tester.pumpAndSettle();

      // The alphabet list or proverb detail should show textual content from sample model
      expect(find.text('ምሳሌ አንድ').hitTestable(), findsWidgets);
    });

    testWidgets('BottomNavigation adapts label on narrow screens', (
      WidgetTester tester,
    ) async {
      // Large screen
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(420, 800)),
            child: Scaffold(
              body: bn.BottomNavigation(
                onTabChange: (_) {},
                selectedTabIndex: 0,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('ስለ መተግበሪያ'), findsOneWidget);

      // Small screen
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(350, 800)),
            child: Scaffold(
              body: bn.BottomNavigation(
                onTabChange: (_) {},
                selectedTabIndex: 0,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('ስለ'), findsWidgets);
    });
  });
}
