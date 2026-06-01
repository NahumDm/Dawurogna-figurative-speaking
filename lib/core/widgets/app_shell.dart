import 'package:dawurogna_figurative_speaking/core/widgets/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavigation(
        selectedTabIndex: navigationShell.currentIndex,
        onTabChange: navigationShell.goBranch,
      ),
    );
  }
}
