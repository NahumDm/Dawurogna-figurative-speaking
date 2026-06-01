import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:share_plus/share_plus.dart';

/// Builds and launches share content for a single proverb (offline-safe).
abstract final class ProverbShareService {
  static String formatProverb(Proverb proverb) {
    return '''
${AppConstants.shareProverbHeader}

${proverb.dawuro.trim()}

${AppConstants.sharePhoneticHeader}

${proverb.phonetic.trim()}

${AppConstants.shareAmharicHeader}

${proverb.amharic.trim()}

${AppConstants.shareProverbFooter}''';
  }

  static Future<void> share(Proverb proverb) async {
    final text = formatProverb(proverb);
    if (text.trim().isEmpty) return;

    await SharePlus.instance.share(
      ShareParams(text: text),
    );
  }
}
