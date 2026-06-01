import 'package:dawurogna_figurative_speaking/core/utils/alphabet_normalizer.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AlphabetNormalizer', () {
    test('maps typographic apostrophe to ASCII S prime', () {
      expect(AlphabetNormalizer.normalize('S\u2019'), "S'");
    });

    test('trims and uppercases', () {
      expect(AlphabetNormalizer.normalize('  sh  '), 'SH');
    });
  });

  group('Proverb.fromJson', () {
    test('normalizes Alphabet field on parse', () {
      final proverb = Proverb.fromJson({
        'id': 857,
        'Alphabet': 'S\u2019',
        'dawurogna': 'x',
        'dawurogna_phonetic': 'y',
        'amharic_translation': 'z',
      });
      expect(proverb.letter, "S'");
    });
  });

  group('letter filter', () {
    test('UI S prime matches proverb parsed from JSON', () {
      final proverb = Proverb.fromJson({
        'id': 857,
        'Alphabet': 'S\u2019',
        'dawurogna': 'a',
        'dawurogna_phonetic': 'b',
        'amharic_translation': 'c',
      });
      final query = AlphabetNormalizer.normalize("S'");
      expect(proverb.letter, query);
    });
  });
}
