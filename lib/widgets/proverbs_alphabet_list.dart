import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

List<String> getProverbsForAlphabet(String alphabet) {
  // TODO: Replace with your actual logic to fetch proverbs for the given alphabet
  // Example implementation:
  Map<String, List<String>> proverbsMap = {
    'A': ['A proverb for A', 'Another proverb for A'],
    'B': ['A proverb for B', 'Another proverb for B'],
    // Add more alphabets and proverbs as needed
  };
  return proverbsMap[alphabet] ?? [];
}

class AlphabetListTile extends StatelessWidget {
  const AlphabetListTile({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final selectedAlphabet =
        GoRouterState.of(context).pathParameters['alphabet'] ?? '';

    // Replace this with your actual list of proverbs for the selected alphabet
    final List<String> proverbsForAlphabet = getProverbsForAlphabet(
      selectedAlphabet,
    );

    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
        ),
        centerTitle: true,
        title: Text(
          "'$selectedAlphabet' ቤት",
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: proverbsForAlphabet.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.background.withOpacity(0.15),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      proverbsForAlphabet[index],
                      style: TextStyle(
                        fontSize: Constants.lgFont,
                        fontWeight: FontWeight.bold,
                        color: Constants.background,
                      ),
                    ),
                    onTap: onTap,
                  ),
                );
              },
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
            ),
          ),
        ],
      ),
    );
  }
}
