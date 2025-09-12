import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactBottomSheet extends StatelessWidget {
  const ContactBottomSheet({super.key});

  // Helper function to launch URLs safely, encapsulated within this widget
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This widget returns the UI for the inside of the sheet
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Constants.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Developer',
            style: TextStyle(
              fontSize: Constants.mdFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _launchUrl(
                    'mailto:nahomdesta.dev@gmail.com?subject=Feedback for Dawurogna App',
                  );
                  Navigator.pop(context); // Close the sheet after tapping
                },
                icon: const Icon(Icons.email_outlined),
                label: const Text('Email'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _launchUrl('https://t.me/NahumD');
                  Navigator.pop(context); // Close the sheet after tapping
                },
                icon: const FaIcon(FontAwesomeIcons.telegram, size: 20),
                label: const Text('Telegram'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
