import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/features/sharing/services/proverb_share_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const proverb = Proverb(
    id: '1',
    letter: 'A',
    dawuro: 'Dawuro text line',
    phonetic: 'Phonetic line',
    amharic: 'Amharic meaning line',
  );

  test('formatProverb includes all sections and footer', () {
    final text = ProverbShareService.formatProverb(proverb);

    expect(text, contains(AppConstants.shareProverbHeader));
    expect(text, contains(proverb.dawuro));
    expect(text, contains(AppConstants.sharePhoneticHeader));
    expect(text, contains(proverb.phonetic));
    expect(text, contains(AppConstants.shareAmharicHeader));
    expect(text, contains(proverb.amharic));
    expect(text, contains(AppConstants.shareProverbFooter));
  });

  test('formatProverb handles long content without truncation', () {
    final long = Proverb(
      id: '2',
      letter: 'B',
      dawuro: 'D' * 500,
      phonetic: 'P' * 500,
      amharic: 'A' * 500,
    );

    final text = ProverbShareService.formatProverb(long);
    expect(text.length, greaterThan(1500));
  });
}
