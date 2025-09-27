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
      padding: const EdgeInsets.all(15.0),
      child: GNav(
        // Google Nav Bar Property
        color: Constants.butttonColor,
        activeColor: Constants.textColor,
        gap: 5.0,
        iconSize: 28.0,
        tabBorderRadius: 10,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        tabBackgroundColor: Constants.background,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 5,
        ), // navigation bar padding
        tabs: [
          GButton(icon: FontAwesomeIcons.list, text: 'ምድብ'),
          GButton(icon: FontAwesomeIcons.circleInfo, text: 'ስለ መተግበሪያ'),
        ],
        selectedIndex: selectedTabIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}
