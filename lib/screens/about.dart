import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class About extends StatelessWidget {
  // final StatefulNavigationShell navigationShell;

  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        centerTitle: true,
        title: const Text(
          'ስለ አፑ',
          style: TextStyle(
            fontFamily: 'Dash',
            fontSize: Constants.mdFont,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            offset: const Offset(0, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Constants.background,
            icon: FaIcon(FontAwesomeIcons.ellipsisVertical),
            onSelected: (String result) {
              switch (result) {
                case 'update':
                  print('update');
                  break;
                case 'contact':
                  print('Contact Selected');
                  break;
                case 'share':
                  SharePlus.instance.share(
                    ShareParams(
                      uri: Uri.parse(
                        "https://play.google.com/store/apps/details?id=com.example.dawurogna_figurative_speaking",
                      ),
                    ),
                  );
                  break;
              }
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem(
                    value: 'update',
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.cloudArrowDown,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          'Check for update',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: Constants.smFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'share',
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.shareNodes,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          'Share app',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: Constants.smFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(), // Creates Horizontal divider
                  const PopupMenuItem(
                    value: 'contact',
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.addressBook,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          'Contact Developer',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: Constants.smFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Center(),
    );
  }
}
