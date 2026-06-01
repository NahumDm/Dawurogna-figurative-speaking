import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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

    final horizontalPadding = compact
        ? 18.0
        : width < 420
        ? 30.0
        : 50.0;
    final iconSize = compact ? 20.0 : 28.0;
    final textFontSize = compact ? 14.0 : 16.0;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: GNav(
        color: colors.brandRed,
        activeColor: scheme.onSurface,
        gap: 5,
        iconSize: iconSize,
        tabBorderRadius: 10,
        tabActiveBorder: Border.all(color: scheme.outline, width: 1),
        tabBackgroundColor: scheme.surface,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 5),
        tabs: [
          GButton(
            icon: Icons.format_list_bulleted,
            text: compact
                ? 'Browse'
                : AppConstants.categoriesTabLabel,
            semanticLabel: AppConstants.categoriesTabLabel,
            textStyle: TextStyle(
              fontSize: textFontSize,
              color: scheme.onSurface,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GButton(
            icon: Icons.star_outline,
            text: compact
                ? AppConstants.favoritesTabLabelCompact
                : AppConstants.favoritesTabLabel,
            semanticLabel: AppConstants.favoritesTabLabel,
            textStyle: TextStyle(
              fontSize: textFontSize,
              color: scheme.onSurface,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GButton(
            icon: Icons.info_outline,
            text: compact
                ? AppConstants.aboutTabLabelCompact
                : AppConstants.aboutTabLabel,
            semanticLabel: AppConstants.aboutTabLabel,
            textStyle: TextStyle(
              fontSize: textFontSize,
              color: scheme.onSurface,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        selectedIndex: selectedTabIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}
