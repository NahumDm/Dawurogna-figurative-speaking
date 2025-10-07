import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.onTabChange,
    required this.selectedTabIndex,
  });

  final ValueChanged<int> onTabChange;
  final int selectedTabIndex;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;

    // Responsive values (tweak thresholds as needed)
    final bool compact = width < 360; // very small devices
    final double horizontalPadding =
        compact ? 18.0 : (width < 420 ? 30.0 : 50.0);
    final double iconSize = compact ? 20.0 : 28.0;
    final double textFontSize =
        compact ? Constants.smFont - 2 : Constants.smFont;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GNav(
        // Google Nav Bar Property
        color: Constants.butttonColor,
        activeColor: Constants.textColor,
        gap: 5.0,
        iconSize: iconSize,
        tabBorderRadius: 10,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        tabBackgroundColor: Constants.background,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 5,
        ), // navigation bar padding (now responsive)
        tabs: [
          GButton(
            icon: FontAwesomeIcons.list,
            text: 'ምድብ',
            textStyle: TextStyle(
              fontSize: textFontSize,
              color: Constants.textColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GButton(
            icon: FontAwesomeIcons.circleInfo,
            // Use a shorter label on very small screens to avoid overflow.
            text: compact ? 'ስለ' : 'ስለ መተግበሪያ',
            textStyle: TextStyle(
              fontSize: textFontSize,
              color: Constants.textColor,
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
