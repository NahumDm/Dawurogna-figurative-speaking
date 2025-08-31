import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:dawurogna_figurative_speaking/Core/Route/route_names.dart';
import 'package:dawurogna_figurative_speaking/widgets/color_indicator.dart';
import 'package:dawurogna_figurative_speaking/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            const SizedBox(height: 25.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                textAlign: TextAlign.center,
                'Dawurotsuwa Tossanne Misayuwa Haasaya Amaaratsuwa Biletsana',
                style: TextStyle(
                  color: Constants.descriptionColor,
                  fontFamily: 'Open-Sans',
                  fontSize: Constants.smFont,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 200.0),

            //Color Indicator
            const ColorIndicator(),
            const SizedBox(height: 15.0),
            // Continue Button
            ContinueButton(
              size: size,
              onpressed: () => context.goNamed(RouteNames.category),
            ),
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
