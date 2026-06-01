import 'package:dawurogna_figurative_speaking/core/router/route_names.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/app_shell.dart';
import 'package:dawurogna_figurative_speaking/features/about/presentation/about_screen.dart';
import 'package:dawurogna_figurative_speaking/features/categories/presentation/category_screen.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/presentation/favorites_screen.dart';
import 'package:dawurogna_figurative_speaking/features/onboarding/presentation/onboarding_screen.dart';
import 'package:dawurogna_figurative_speaking/features/proverb_detail/presentation/proverb_detail_screen.dart';
import 'package:dawurogna_figurative_speaking/features/proverb_list/presentation/proverb_list_screen.dart';
import 'package:dawurogna_figurative_speaking/features/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      name: RouteNames.onboarding,
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: RouteNames.eachAlphabetList,
      path: '/eachAlphabetList/:alphabet',
      builder: (context, state) {
        final alphabet = state.pathParameters['alphabet'] ?? '';
        return ProverbListScreen(letter: alphabet);
      },
    ),
    GoRoute(
      name: RouteNames.taleDetail,
      path: '/tale/:id',
      pageBuilder: (context, state) {
        final proverbId = state.pathParameters['id'] ?? '';
        final direction = state.extra as Offset? ?? const Offset(1, 0);

        return CustomTransitionPage(
          key: state.pageKey,
          child: ProverbDetailScreen(proverbId: proverbId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(begin: direction, end: Offset.zero)
                  .animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  ),
              child: child,
            );
          },
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteNames.category,
              path: '/category',
              builder: (context, state) => const CategoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteNames.favorites,
              path: '/favorites',
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteNames.about,
              path: '/about',
              builder: (context, state) => const AboutScreen(),
              routes: [
                GoRoute(
                  name: RouteNames.settings,
                  path: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
