import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:dawurogna_figurative_speaking/Widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        title: Text(
          'ዳውሮኛ ተረትና ምሳሌ',
          style: TextStyle(
            color: Constants.textColor,
            fontFamily: 'Dash',
            fontSize: Constants.mdFont,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(child: Text("Helloooo")),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Constants.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Constants.descriptionColor.withOpacity(.08),
            ),
          ],
        ),
        child: BottomNavigation(
          onTabChange: (index) {
            setState(() {
              _selectedTabIndex = index;
              if (index == 0) {
                context.goNamed('category');
              } else if (index == 1) {
                context.goNamed('settings');
              } else if (index == 2) {
                context.goNamed('about');
              }
            });
          },
        ),
      ),
    );
  }
}
