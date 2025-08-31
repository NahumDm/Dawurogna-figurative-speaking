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

    final currentAlphabet = proverb.alphabet;

    //Data needed for navigation
    final provider = context.read<ProverbsProvider>();
    final allProverbs = provider.allProverbs;
    final currentIndex = allProverbs.indexWhere((p) => p.id == proverb.id);

    // Determine if a next or previous proverb exists
    final bool hasNext = currentIndex < allProverbs.length - 1;
    final bool hasPrevious = currentIndex > 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        leading: IconButton(
          onPressed: () => context.go('/eachAlphabetList/$currentAlphabet'),
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Constants.textColor,
            size: 20,
          ),
        ),
        title: Text(
          'ዳውሮኛ ተረትና ምሳሌ',
          style: const TextStyle(
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
            decoration: const BoxDecoration(
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
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    proverb.dawurogna,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      letterSpacing: 1.5,
                      fontFamily: 'Roboto',
                      color: Constants.background,
                      fontSize: Constants.lgFont,
                      fontWeight: FontWeight.w900,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    proverb.dawurognaPhonetic,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      color: Constants.background,
                      fontSize: Constants.lgFont,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    proverb.amharicTranslation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      color: Constants.background,
                      fontSize: Constants.lgFont,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          //Navigation Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 80.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Condition for navigation buttons
                  if (hasPrevious)
                    IconButton(
                      onPressed: () {
                        final previousID = allProverbs[currentIndex - 1].id;
                        context.push('/tale/$previousID');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.circleChevronLeft,
                        size: 45.0,
                        color: Constants.iconColor,
                      ),
                    ),

                  if (hasNext)
                    IconButton(
                      onPressed: () {
                        final nextID = allProverbs[currentIndex + 1].id;
                        context.push('/tale/$nextID');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.circleChevronRight,
                        size: 45.0,
                        color: Constants.iconColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
