import 'package:dawurogna_figurative_speaking/Screens/about.dart';
import 'package:dawurogna_figurative_speaking/Screens/category.dart';
import 'package:dawurogna_figurative_speaking/Screens/onboarding.dart';
import 'package:dawurogna_figurative_speaking/Screens/settings.dart';
import 'package:go_router/go_router.dart';

final routeProvider = GoRouter(
  initialLocation: "/onboarding",
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      name: 'category',
      path: '/category',
      builder: (context, state) => const Category(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const Settings(),
    ),
    GoRoute(
      name: 'about',
      path: '/about',
      builder: (context, state) => const About(),
    ),
  ],
);
