import 'package:dawurogna_figurative_speaking/Core/Route/route_names.dart';
import 'package:dawurogna_figurative_speaking/Screens/about.dart';
import 'package:dawurogna_figurative_speaking/Screens/category.dart';
import 'package:dawurogna_figurative_speaking/Screens/onboarding.dart';
import 'package:dawurogna_figurative_speaking/Screens/proverb_detail.dart';
import 'package:dawurogna_figurative_speaking/Widgets/appshell.dart';
import 'package:dawurogna_figurative_speaking/Widgets/proverbs_alphabet_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routeProvider = GoRouter(
  initialLocation: "/onboarding",
  routes: [
    GoRoute(
      name: RouteNames.onboarding,
      path: '/onboarding',
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      name: RouteNames.eachAlphabetList,
      path: '/eachAlphabetList/:alphabet',
      builder: (context, state) => const AlphabetListTile(),
    ),
    GoRoute(
      name: RouteNames.taleDetail,
      path: '/tale/:id',
      pageBuilder: (context, state) {
        final proverbId = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;

        // Get the slide direction from the 'extra' parameter passed during navigation.
        // Default to a standard slide-in from the right if no direction is provided.
        final direction = state.extra as Offset? ?? const Offset(1.0, 0.0);

        return CustomTransitionPage(
          key: state.pageKey,
          child: ProverbDetailScreen(proverbId: proverbId),
          // Define the transition logic directly here
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: direction,
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: child,
            );
          },
        );
      },
    ),

    /* Main App Shell That Contains the Bottom Navigation Bar
    and Indexed Stack for Navigation. This enables the bottom navigation to stay persistent
    while switching between different screens.
    */
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
              builder: (context, state) => const Category(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteNames.about,
              path: '/about',
              builder: (context, state) => const About(),
            ),
          ],
        ),
      ],
    ),
  ],
);
