import 'package:dawurogna_figurative_speaking/Widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // This displays the current branch's screen
      bottomNavigationBar: BottomNavigation(
        selectedTabIndex: navigationShell.currentIndex,
        onTabChange: (index) => navigationShell.goBranch(index),
      ),
    );
  }
}
