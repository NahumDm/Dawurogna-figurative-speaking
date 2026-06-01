import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/router/app_router.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_theme.dart';
import 'package:dawurogna_figurative_speaking/core/theme/theme_controller.dart';
import 'package:dawurogna_figurative_speaking/data/repositories/proverbs_repository.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/data/favorite_repository.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/favorites_controller.dart';
import 'package:dawurogna_figurative_speaking/features/proverbs/proverbs_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const AppBootstrap());
}

/// Loads persisted theme and favorites storage before showing the main app.
class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  ThemeController? _themeController;
  FavoriteRepository? _favoriteRepository;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final themeController = ThemeController();
    await themeController.loadFromStorage();

    final favoriteRepository = FavoriteRepositoryImpl();
    await favoriteRepository.init();

    if (mounted) {
      setState(() {
        _themeController = themeController;
        _favoriteRepository = favoriteRepository;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = _themeController;
    final favoriteRepository = _favoriteRepository;

    if (themeController == null || favoriteRepository == null) {
      return MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return DawurognaApp(
      themeController: themeController,
      favoriteRepository: favoriteRepository,
    );
  }
}

class DawurognaApp extends StatefulWidget {
  const DawurognaApp({
    super.key,
    required this.themeController,
    required this.favoriteRepository,
  });

  final ThemeController themeController;
  final FavoriteRepository favoriteRepository;

  @override
  State<DawurognaApp> createState() => _DawurognaAppState();
}

class _DawurognaAppState extends State<DawurognaApp> {
  late final ProverbsRepository _proverbsRepository = ProverbsRepositoryImpl();
  late final ProverbsController _proverbsController;
  late final FavoritesController _favoritesController;

  @override
  void initState() {
    super.initState();
    _proverbsController = ProverbsController(_proverbsRepository);
    _favoritesController = FavoritesController(
      favoriteRepository: widget.favoriteRepository,
      proverbsRepository: _proverbsRepository,
    );
    _proverbsController.loadProverbs();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.themeController,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConstants.materialAppTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: widget.themeController.themeMode,
          routerConfig: appRouter,
          builder: (context, child) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ThemeController>.value(
                  value: widget.themeController,
                ),
                ChangeNotifierProvider<ProverbsController>.value(
                  value: _proverbsController,
                ),
                ChangeNotifierProvider<FavoritesController>.value(
                  value: _favoritesController,
                ),
              ],
              child: UpgradeAlert(
                upgrader: Upgrader(
                  durationUntilAlertAgain: const Duration(days: 2),
                ),
                navigatorKey: appRouter.routerDelegate.navigatorKey,
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
        );
      },
    );
  }
}
