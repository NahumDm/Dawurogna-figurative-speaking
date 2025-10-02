import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactBottomSheet extends StatelessWidget {
  const ContactBottomSheet({super.key});

  // Helper function to launch URLs safely, encapsulated within this widget
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {}
  }

  @override
  Widget build(BuildContext context) {
    // This widget returns the UI for the inside of the sheet
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Constants.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            textAlign: TextAlign.center,
            'Contact Developer',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: Constants.mdFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.subtitle,
                  foregroundColor: Constants.background,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  _launchUrl(
                    'mailto:nahomdesta.dev@gmail.com?subject=Feedback for Dawurogna App',
                  );
                  Navigator.pop(context); // Close the sheet after tapping
                },
                icon: const FaIcon(FontAwesomeIcons.solidEnvelope),
                label: const Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: Constants.mdFont,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.subtitle,
                  foregroundColor: Constants.background,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  _launchUrl('https://t.me/NahumD');
                  Navigator.pop(context); // Close the sheet after tapping
                },
                icon: const FaIcon(FontAwesomeIcons.telegram, size: 20),
                label: const Text(
                  'Telegram',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: Constants.mdFont,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
