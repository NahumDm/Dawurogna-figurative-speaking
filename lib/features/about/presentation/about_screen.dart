import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/router/route_names.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/dawuro_app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = Responsive.horizontalPadding(context);
    final maxWidth = Responsive.contentMaxWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: const DawuroAppBarTitle(AppConstants.aboutTitle),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(RouteNames.settings),
            icon: const Icon(Icons.settings_outlined),
            tooltip: AppConstants.settingsTitle,
          ),
        ],
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(padding, 8, padding, 24),
              child: _AboutContent(theme: theme),
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = theme.textTheme.bodyLarge?.copyWith(height: 1.55);
    final mutedStyle = theme.textTheme.bodyMedium;
    final emphasisStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return SelectableText.rich(
      TextSpan(
        style: bodyStyle,
        children: [
          TextSpan(
            text: 'ይህ ሥራ ከዚህ በፊት በ1998 ዓ/ም ',
            style: mutedStyle,
          ),
          TextSpan(
            text: 'በአቶ ዱባለ ገበየሁ ገንበዞ ',
            style: emphasisStyle,
          ),
          TextSpan(
            text:
                "‘የዳዉሮኛ ተረትና ምሳሌዎች’ በሚል ርዕስ በመጽሐፍ መልክ ታትሞ ለምንባብ መብቃቱ ይታወሳል፡፡ ሥራዉ የዳዉሮን ብሔር ባህልና ቋንቋ ሰንዶ ለትዉልድ ከማስተላለፍ አኳያ ፈርቀዳጅ አስተዋጽኦ እንደነበር ይታመናል፡፡ ይሁን እንጂ ይህንን ሥራ ለአጠቃቀም ቀላልና ምቹ በሆነ አግባብ ከዘመኑ የቴክኖሎጂ ዕድገት ደረጃ ጋር የሚጣጣም አድርጎ ማቅረቡ ወቅቱ የሚፈልገዉ ጉዳይ ሆኗል፡፡ በመሆኑም ተረትና ምሳሌዎቹ በዲጂታል አማራጭነት በመተግበሪያ (Application) መልክ ተሰንዶ ለቋንቋዉ ባለቤት ህዝብና በዘርፉ ለሚመራመሩ ግለሰቦች በቀላሉ ተደራሽ እንድሆን መነሳሳቱን ለወሰደዉ ለወጣቱ የሶፍትዌር (Software) ተማሪ ለሆነዉ ለወጣት ናሆም ደስታ መንገሻ ላቅ ያለ ምስጋናዬን በራሴና በቋንቋዉ ተጠቃሚ ማህበረሰብ ስም ላቅ ያለ ምስጋናዬን አቀርባለሁ፡፡\n\n",
            style: mutedStyle,
          ),
          TextSpan(
            text:
                'መተግበሪያዉን ለሚጠቀሙ ሰዎች ይረዳ ዘንድ አንዳንድ የዳዉሮኛ ቋንቋ (Dawurotsuwaa) ድምፆች አጻጻፍና አነባብ (Orthography) እንደሚከተለዉ ቀርቧል፡፡ የዳዉሮኛ ቋንቋ የላቲን አጻጻፍ ስልት የሚከተል ሲሆን በዚህ ሥራ ',
            style: mutedStyle,
          ),
          TextSpan(
            text: "C ፤ Ch ፤ Dh ፤ K’ ፤ P’ ፤ S’ ፤ Ts ፤ እና Zh ",
            style: emphasisStyle,
          ),
          TextSpan(
            text: 'አነባባቸዉ ከሌሎች ተነባቢና አናባቢ ድምፆች ለየት ስለሚል',
            style: mutedStyle,
          ),
          TextSpan(
            text: ' C/ጨ ፤ Ch/ቸ ፤ Dh/ደ’',
            style: emphasisStyle,
          ),
          TextSpan(
            text:
                ' (የምላስ ጫፍ የድድን ጣሪያ በሚነካበት ወቅት የሚፈጠር ፈንጂ [Explosive] ደምፅ ',
            style: mutedStyle,
          ),
          TextSpan(
            text: "K’/ቀ ፤ P’/ጰ ፤ S’/ጸ ፤ እና Ts/ፀ’ ",
            style: emphasisStyle,
          ),
          TextSpan(
            text:
                '(ከእንግልዝኛዉ /θ/ ጋር ተቀራራቢ ድምፅ ያለዉና የላይኛዉ የጥርሳችን ጠርዝ የምላሳችንን የፊተኛዉን ከፍል መሀል በሚነካበት ሰዓት የሚፈጠር ፍትግ [Fricative] ድምፆችን እንዲወክሉ ተደርገዋል፡፡\n\n',
            style: mutedStyle,
          ),
          TextSpan(
            text:
                'በመጨረሻም ማንኛዉም የጽሑፍ ሥራ የራሱ የሆኑ ዉስንነቶች እንዳሉት ሁሉ ይህም ሥራ ከስህተት የፀዳ አለመሆኑ ይታመናል፡፡ በመሆኑም በሥራዉ ላይ ሊታዩ የምችሉ ስህተቶችና ጉድለቶች ወደፊት ግዜና ሁኔታ ሲፈቅድ የሚታረሙና የሚስተካከሉ መሆናቸዉን እያረጋገጥኩ ስህተቶቹ የዚህን መተግበሪያ አልሚ (Application Developer) ወጣት ናሆም ደስታ መንገሻን የማይመለከቱና ሙሉ በሙሉ የእኔ መሆናቸዉን ለመተግበሪያዉ ተጠቃሚዎች ለማስገንዘብ እወዳለሁ፡፡\n\n',
            style: mutedStyle,
          ),
          TextSpan(
            text: 'ዱባለ ገበየሁ ገንበዞ \nመስከረም 14/2018 ዓ/ም \nሀዋሳ ዩኒቨርሲቲ \n',
            style: emphasisStyle,
          ),
        ],
      ),
      textAlign: TextAlign.justify,
    );
  }
}
