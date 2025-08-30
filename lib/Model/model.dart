class ProverbModel {
  final int id;
  final String alphabet;
  final String dawurogna;
  final String dawurognaPhonetic;
  final String amharicTranslation;

  ProverbModel({
    required this.id,
    required this.alphabet,
    required this.dawurogna,
    required this.amharicTranslation,
    required this.dawurognaPhonetic,
  });

  //Converting JSON into Object
  factory ProverbModel.fromJson(Map<String, dynamic> json) {
    return ProverbModel(
      id: json['id'] as int,
      alphabet: json['Alphabet'] as String? ?? '',
      dawurogna: json['dawurogna'] as String? ?? '',
      amharicTranslation: json['amharic_translation'] as String? ?? '',
      dawurognaPhonetic: json['dawurogna_phonetic'] as String? ?? '',
    );
  }
}
