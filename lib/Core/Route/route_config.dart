import 'package:dawurogna_figurative_speaking/Core/Route/route_names.dart';
import 'package:dawurogna_figurative_speaking/Screens/about.dart';
import 'package:dawurogna_figurative_speaking/Screens/category.dart';
import 'package:dawurogna_figurative_speaking/Screens/onboarding.dart';
import 'package:dawurogna_figurative_speaking/Screens/settings.dart';
import 'package:dawurogna_figurative_speaking/Widgets/appshell.dart';
import 'package:go_router/go_router.dart';

final routeProvider = GoRouter(
  initialLocation: "/onboarding",
  routes: [
    GoRoute(
      name: RouteNames.onboarding,
      path: '/onboarding',
      builder: (context, state) => const Onboarding(),
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
              builder: (context, state) => Category(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteNames.settings,
              path: '/settings',
              builder: (context, state) => Settings(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteNames.about,
              path: '/about',
              builder: (context, state) => About(),
            ),
          ],
        ),
      ],
    ),
  ],
);
