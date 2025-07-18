import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,

      //AppBar Title
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
    );
  }
}
