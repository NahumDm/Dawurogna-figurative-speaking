import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:dawurogna_figurative_speaking/Provider/proverbs_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AlphabetListTile extends StatelessWidget {
  const AlphabetListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAlphabet =
        GoRouterState.of(context).pathParameters['alphabet'] ??
        ''; //get selected alphabet from router parameters

    // Watch provider for change
    final provider = context.watch<ProverbsProvider>();

    final proverbsForAlphabet = provider.getProverbsByAlphabet(
      selectedAlphabet,
    ); // get filtered list of proverbs from the provider

    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
        ),
        centerTitle: true,
        title: Text(
          " ' $selectedAlphabet ' ",
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
      ),
      body:
          provider.isLoading
              ? const Center(
                child: CircularProgressIndicator(), // show loading spinner
              )
              : proverbsForAlphabet.isEmpty
              ? const Center(child: Text('No proverb found for this letter.'))
              : ListView.separated(
                itemCount: proverbsForAlphabet.length,
                itemBuilder: (context, index) {
                  final proverb =
                      proverbsForAlphabet[index]; //Get specific proverb
                  return ListTile(
                    dense: true,
                    title: Text(
                      proverb.dawurogna,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: Constants.mdFont,
                        fontWeight: FontWeight.w500,
                        color: Constants.textColor,
                      ),
                    ),
                    onTap: () {
                      context.push('/tale/${proverb.id}');
                    },
                  );
                },
                separatorBuilder:
                    (context, index) => const Divider(
                      color: Constants.title,
                      thickness: 0.2,
                      height: 0.7,
                    ),

                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
              ),
    );
  }
}
