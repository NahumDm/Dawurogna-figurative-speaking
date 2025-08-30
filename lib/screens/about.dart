import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:dawurogna_figurative_speaking/Widgets/proverbs_detail_container.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  // final StatefulNavigationShell navigationShell;

  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        centerTitle: true,
        title: const Text(
          'ስለ አፑ',
          style: TextStyle(
            fontFamily: 'Dash',
            fontSize: Constants.mdFont,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(),
    );
  }
}
