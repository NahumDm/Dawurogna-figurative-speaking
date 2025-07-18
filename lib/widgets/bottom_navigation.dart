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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: GNav(
        // Google Nav Bar Property
        color: Constants.butttonColor,
        activeColor: Constants.iconColor,
        gap: 8.0,
        iconSize: 28.0,
        tabBorderRadius: 10,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        tabBackgroundColor: Constants.background,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ), // navigation bar padding
        tabs: [
          GButton(icon: FontAwesomeIcons.list, text: 'Category'),
          GButton(icon: FontAwesomeIcons.gear, text: 'Settings'),
          GButton(icon: FontAwesomeIcons.circleInfo, text: 'About'),
        ],
        selectedIndex: selectedTabIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}
