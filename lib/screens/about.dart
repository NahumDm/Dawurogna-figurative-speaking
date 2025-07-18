import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About',
          style: TextStyle(
            fontFamily: 'Dash',
            fontSize: Constants.mdFont,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(child: Text('Hiiiii')),
    );
  }
}
