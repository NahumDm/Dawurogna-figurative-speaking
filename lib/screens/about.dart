import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
import 'package:dawurogna_figurative_speaking/Widgets/contact_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';

class About extends StatelessWidget {
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
            icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
            onSelected: (String result) async {
              switch (result) {
                case 'update':
                  final upgrader = Upgrader();
                  await upgrader.initialize(); // Ensure Upgrader is initialized

                  if (upgrader.isUpdateAvailable()) {
                    // Show custom update dialog
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Update Available'),
                            content: Text(
                              upgrader.releaseNotes ??
                                  'A new version is available!',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Later'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final url =
                                      upgrader.currentAppStoreListingURL;
                                  if (url != null &&
                                      await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(
                                      Uri.parse(url),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                child: const Text('Update'),
                              ),
                            ],
                          ),
                    );
                  } else {
                    // Show up-to-date message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Your app is up to date!')),
                    );
                  }
                  break;
                case 'contact':
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const ContactBottomSheet();
                    },
                  );
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

            // More Option Logic
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
                  const PopupMenuDivider(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: Constants.mdFont,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "ይህ ሥራ ከዚህ በፊት በ1998 ዓ/ም ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800],
                          ),
                        ),
                        TextSpan(
                          text: "በአቶ ዱባለ ገበየሁ ገንበዞ ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.textColor,
                          ),
                        ),
                        TextSpan(
                          text:
                              "'የዳዉሮኛ ተረትና ምሳሌዎች' በሚል ርዕስ በመጽሐፍ መልክ ታትሞ ለምንባብ መብቃቱ ይታወሳል፡፡ ሥራዉ የዳዉሮን ብሔር ባህልና ቋንቋ ሰንዶ ለትዉልድ ከማስተላለፍ አኳያ ፈርቀዳጅ አስተዋጽኦ እንደነበር ይታመናል፡፡ ይሁን እንጂ ይህንን ሥራ ለአጠቃቀም ቀላልና ምቹ በሆነ አግባብ ከዘመኑ የቴክኖሎጂ ዕድገት ደረጃ ጋር የሚጣጣም አድርጎ ማቅረቡ ወቅቱ የሚፈልገዉ ጉዳይ ሆኗል፡፡ በመሆኑም ተረትና ምሳሌዎቹ በዲጂታል አማራጭነት በመተግበሪያ (Application) መልክ ተሰንዶ ለቋንቋዉ ባለቤት ህዝብና በዘርፉ ለሚመራመሩ ግለሰቦች በቀላሉ ተደራሽ እንድሆን መነሳሳቱን ለወሰደዉ ለወጣቱ የሶፍትዌር (Software) ተማሪ ለሆነዉ ለወጣት ናሆም ደስታ መንገሻ ላቅ ያለ ምስጋናዬን በራሴና በቋንቋዉ ተጠቃሚ ማህበረሰብ ስም ላቅ ያለ ምስጋናዬን አቀርባለሁ፡፡\n\n",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "መተግበሪያዉን ለሚጠቀሙ ሰዎች ይረዳ ዘንድ አንዳንድ የዳዉሮኛ ቋንቋ (Dawurotsuwaa) ድምፆች አጻጻፍና አነባብ (Orthography) እንደሚከተለዉ ቀርቧል፡፡ የዳዉሮኛ ቋንቋ የላቲን አጻጻፍ ስልት የሚከተል ሲሆን በዚህ ሥራ ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800],
                          ),
                        ),
                        TextSpan(
                          text: "C ፤ Ch ፤ Dh ፤ K’ ፤ P’ ፤ S’ ፤ Ts ፤ እና Zh ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.textColor,
                          ),
                        ),
                        TextSpan(
                          text: "አነባባቸዉ ከሌሎች ተነባቢና አናባቢ ድምፆች ለየት ስለሚል",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800],
                          ),
                        ),
                        TextSpan(
                          text: " C/ጨ ፤ Ch/ቸ ፤ Dh/ደ’",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.textColor,
                          ),
                        ),
                        TextSpan(
                          text:
                              " (የምላስ ጫፍ የድድን ጣሪያ በሚነካበት ወቅት የሚፈጠር ፈንጂ [Explosive] ደምፅ ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800],
                          ),
                        ),
                        TextSpan(
                          text: "K’/ቀ ፤ P’/ጰ ፤ S’/ጸ ፤ እና Ts/ፀ’ ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.textColor,
                          ),
                        ),
                        TextSpan(
                          text:
                              "(ከእንግልዝኛዉ /θ/ ጋር ተቀራራቢ ድምፅ ያለዉና የላይኛዉ የጥርሳችን ጠርዝ የምላሳችንን የፊተኛዉን ከፍል መሀል በሚነካበት ሰዓት የሚፈጠር ፍትግ [Fricative] ድምፆችን እንዲወክሉ ተደርገዋል፡፡\n\n",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    TextSpan(
                      text:
                          "በመጨረሻም ማንኛዉም የጽሑፍ ሥራ የራሱ የሆኑ ዉስንነቶች እንዳሉት ሁሉ ይህም ሥራ ከስህተት የፀዳ አለመሆኑ ይታመናል፡፡ በመሆኑም በሥራዉ ላይ ሊታዩ የምችሉ ስህተቶችና ጉድለቶች ወደፊት ግዜና ሁኔታ ሲፈቅድ የሚታረሙና የሚስተካከሉ መሆናቸዉን እያረጋገጥኩ ስህተቶቹ የዚህን መተግበሪያ አልሚ (Application Developer) ወጣት ናሆም ደስታ መንገሻን የማይመለከቱና ሙሉ በሙሉ የእኔ መሆናቸዉን ለመተግበሪያዉ ተጠቃሚዎች ለማስገንዘብ እወዳለሁ፡፡\n\n",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[800],
                      ),
                    ),
                    TextSpan(
                      text: "ዱባለ ገበየሁ ገንበዞ \nመስከረም 14/2018 ዓ/ም \nሀዋሳ ዩኒቨርሲቲ \n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constants.textColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
