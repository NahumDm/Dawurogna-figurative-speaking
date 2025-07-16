import 'package:dawurogna_figurative_speaking/constants/constants.dart';
import 'package:dawurogna_figurative_speaking/widgets/color_indicator.dart';
import 'package:dawurogna_figurative_speaking/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Book Image
            const BookImage(),
            SizedBox(height: 15.0),
            const Text(
              'ዳውሮኛ ተረትና ምሳሌ',
              style: TextStyle(
                color: Constants.title,
                fontFamily: 'Dash',
                fontSize: Constants.lgFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Dawurogna Tales & Saying',
              style: TextStyle(
                color: Constants.subtitle,
                fontFamily: 'Roboto',
                fontSize: Constants.mdFont,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                textAlign: TextAlign.center,
                'Preserving the rich oral traditions and wisdom of the Dawuro people for future generations.',
                style: TextStyle(
                  color: Constants.descriptionColor,
                  fontFamily: 'Open-Sans',
                  fontSize: Constants.smFont,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 200.0),

            //Color Indicator
            ColorIndicator(),
            SizedBox(height: 15.0),
            // Continue Button
            ContinueButton(size: size),
          ],
        ),
      ),
    );
  }
}

// Book Image Widget

class BookImage extends StatelessWidget {
  const BookImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: BeveledRectangleBorder(
      //   borderRadius: BorderRadius.circular(5.0),
      // ),
      shadowColor: Constants.textColor,
      elevation: 1,
      child: Image.asset(
        'assets/images/book_icon.png',
        height: Constants.bookHeight,
        width: Constants.bookWidth,
      ),
    );
  }
}
