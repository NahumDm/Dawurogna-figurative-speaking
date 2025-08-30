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
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        ),
        title: const Text('Proverb Detail'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(
              title: 'Dawurogna Proverb',
              content: proverb.dawurogna,
            ),
            const SizedBox(height: 20),
            _buildDetailCard(
              title: 'Amharic Phonetic',
              content: proverb.dawurognaPhonetic,
            ),
            const SizedBox(height: 20),
            _buildDetailCard(
              title: 'Amharic Translation',
              content: proverb.amharicTranslation,
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build styled cards for details
  Widget _buildDetailCard({required String title, required String content}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Constants.mdFont,
                fontWeight: FontWeight.bold,
                color: Constants.title,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: Constants.mdFont,
                height: 1.5, // Improves readability
                color: Constants.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
