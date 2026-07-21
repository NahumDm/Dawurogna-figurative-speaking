import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.onTabChange,
    required this.selectedTabIndex,
  });

  final ValueChanged<int> onTabChange;
  final int selectedTabIndex;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final scheme = Theme.of(context).colorScheme;
    final compact = Responsive.isCompact(context);
    final width = MediaQuery.sizeOf(context).width;
    final useCompactLayout = compact || width < 520;

    final items = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.format_list_bulleted),
        label: useCompactLayout ? 'Browse' : AppConstants.categoriesTabLabel,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.star_outline),
        label: useCompactLayout
            ? AppConstants.favoritesTabLabelCompact
            : AppConstants.favoritesTabLabel,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.info_outline),
        label: useCompactLayout
            ? AppConstants.aboutTabLabelCompact
            : AppConstants.aboutTabLabel,
      ),
    ];

    return BottomNavigationBar(
      currentIndex: selectedTabIndex,
      onTap: onTabChange,
      type: BottomNavigationBarType.fixed,
      backgroundColor: scheme.surface,
      selectedItemColor: colors.brandRed,
      unselectedItemColor: scheme.onSurfaceVariant,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: items
          .map(
            (item) => BottomNavigationBarItem(
              icon: item.icon,
              label: item.label ?? '',
            ),
          )
          .toList(),
    );
  }
}
