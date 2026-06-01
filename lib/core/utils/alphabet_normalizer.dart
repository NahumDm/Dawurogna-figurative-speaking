/// Normalizes Dawuro alphabet category labels from bundled JSON.
///
/// Some entries use typographic apostrophe (U+2019) while the UI uses ASCII
/// apostrophe (U+0027), e.g. JSON `S’` vs app `S'`.
abstract final class AlphabetNormalizer {
  static const String _asciiApostrophe = "'";

  /// Canonical form used for storage, routing, and letter filters.
  static String normalize(String letter) {
    return letter
        .trim()
        .replaceAll('\u2019', _asciiApostrophe) // ’ RIGHT SINGLE QUOTATION
        .replaceAll('\u2018', _asciiApostrophe) // ‘ LEFT SINGLE QUOTATION
        .replaceAll('\u02BC', _asciiApostrophe) // ʼ MODIFIER LETTER APOSTROPHE
        .replaceAll('\u2032', _asciiApostrophe) // ′ PRIME
        .toUpperCase();
  }
}
