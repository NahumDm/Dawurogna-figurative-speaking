import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:dawurogna_figurative_speaking/Provider/proverbs_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProverbDetailScreen extends StatelessWidget {
  final int proverbId;
  const ProverbDetailScreen({super.key, required this.proverbId});

  @override
  Widget build(BuildContext context) {
    // Find the specific proverb using the provider
    final proverb = context.read<ProverbsProvider>().getProverbById(proverbId);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Constants.textColor,
            size: 20,
          ),
        ),
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
      body: Stack(
        children: [
          //Background Image Display
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dawuro_gihibli.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //To Darken Image Opacity
          Container(color: Colors.black.withOpacity(0.5)),

          //Proverb Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    proverb.dawurogna,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Constants.background,
                      fontSize: Constants.lgFont,
                      fontWeight: FontWeight.w900,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    proverb.dawurognaPhonetic,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Constants.background,
                      fontSize: Constants.lgFont,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    proverb.amharicTranslation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Constants.background,
                      fontSize: Constants.lgFont,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
