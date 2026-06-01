import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';

/// Deterministic daily proverb selection (offline, no network).
class ProverbOfDayService {
  const ProverbOfDayService();

  /// 1-based day index for [date] (Jan 1 = 1).
  int dayOfYear(DateTime date) {
    final start = DateTime(date.year, 1, 1);
    return date.difference(start).inDays + 1;
  }

  /// Picks one proverb per calendar day: `dayOfYear % total`.
  Proverb? selectForDate(List<Proverb> proverbs, [DateTime? date]) {
    if (proverbs.isEmpty) return null;

    final today = _dateOnly(date ?? DateTime.now());
    final index = (dayOfYear(today) - 1) % proverbs.length;
    return proverbs[index];
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
