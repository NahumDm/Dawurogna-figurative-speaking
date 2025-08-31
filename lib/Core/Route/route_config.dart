import 'package:dawurogna_figurative_speaking/Core/Route/route_names.dart';
import 'package:dawurogna_figurative_speaking/Screens/about.dart';
import 'package:dawurogna_figurative_speaking/Screens/category.dart';
import 'package:dawurogna_figurative_speaking/Screens/onboarding.dart';
import 'package:dawurogna_figurative_speaking/Screens/proverb_detail.dart';
import 'package:dawurogna_figurative_speaking/Widgets/appshell.dart';
import 'package:dawurogna_figurative_speaking/Widgets/proverbs_alphabet_list.dart';
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
      builder: (context, state) => AlphabetListTile(),
    ),
    GoRoute(
      name: RouteNames.taleDetail,
      path: '/tale/:id',
      builder: (context, state) {
        // 1. Get the 'id' from path parameters. It's a String?.
        final proverbIdString = state.pathParameters['id'];
        // 2. Parse the String to an int. Handle potential nulls.
        final proverbId = int.tryParse(proverbIdString ?? '') ?? 0;
        // 3. Pass the int to your screen.
        return ProverbDetailScreen(proverbId: proverbId);
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
              builder: (context, state) => Category(),
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
