import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:dawurogna_figurative_speaking/Core/Route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> alphabet = [
    "A",
    "B",
    "C'",
    "D",
    "E",
    "G",
    "H",
    "I",
    "J",
    "K",
    "K'",
    "L",
    "M",
    "N",
    "O",
    "P",
    "S",
    "SH",
    "S’",
    "T",
    "U",
    "W",
    "Y",
    "Z",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,

      //AppBar Title
      appBar: AppBar(
        backgroundColor: Constants.background,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProverbsListView(
                alphabet: alphabet,
                onTap: (selectedLetter) {
                  context.pushNamed(
                    RouteNames.eachAlphabetList,
                    pathParameters: {'alphabet': selectedLetter},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Category by Alphabetical Order List
class ProverbsListView extends StatelessWidget {
  final List<String> alphabet;
  final ValueChanged<String> onTap;

  const ProverbsListView({
    super.key,
    required this.alphabet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: alphabet.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Constants.textColor.withOpacity(0.15),
                blurRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              alphabet[index],
              style: const TextStyle(
                fontSize: Constants.lgFont,
                fontWeight: FontWeight.w500,
                color: Constants.textColor,
              ),
            ),
            onTap: () => onTap(alphabet[index]),
          ),
        );
      },
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
    );
  }
}
