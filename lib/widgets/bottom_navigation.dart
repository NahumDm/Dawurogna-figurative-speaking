import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key, required this.onTabChange});

  final ValueChanged<int> onTabChange;
  final int _selectedTabIndex = 0;

  final List<Widget> _tabs = [
    Text('Category'),
    Text('Settings'),
    Text('About'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: GNav(
        color: Constants.butttonColor,
        activeColor: Constants.iconColor,
        gap: 8.0,
        iconSize: 28.0,
        tabBorderRadius: 10,
        // curve: Curves.easeOutExpo, // tab animation curves
        tabActiveBorder: Border.all(
          color: Colors.black,
          width: 1,
        ), // tab button border
        // tabBorder: Border.all(width: 1.0, color: Constants.descriptionColor),
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
        selectedIndex: _selectedTabIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}
