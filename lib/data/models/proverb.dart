import 'package:dawurogna_figurative_speaking/core/utils/alphabet_normalizer.dart';
import 'package:flutter/foundation.dart';

@immutable
class Proverb {
  const Proverb({
    required this.id,
    required this.letter,
    required this.dawuro,
    required this.phonetic,
    required this.amharic,
  });

  final String id;
  final String letter;
  final String dawuro;
  final String phonetic;
  final String amharic;

  factory Proverb.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    return Proverb(
      id: rawId?.toString() ?? '',
      letter: AlphabetNormalizer.normalize(
        json['Alphabet'] as String? ?? '',
      ),
      dawuro: json['dawurogna'] as String? ?? '',
      phonetic: json['dawurogna_phonetic'] as String? ?? '',
      amharic: json['amharic_translation'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'Alphabet': letter,
    'dawurogna': dawuro,
    'dawurogna_phonetic': phonetic,
    'amharic_translation': amharic,
  };

  /// Stable ordering key preserved from legacy numeric ids.
  int get sortKey => int.tryParse(id) ?? 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Proverb &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
