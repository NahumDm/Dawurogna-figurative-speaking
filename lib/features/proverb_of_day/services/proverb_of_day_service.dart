import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';

/// Deterministic daily proverb selection using the device **local calendar date**.
///
/// Fully offline — no network, not affected by debug/release mode.
class ProverbOfDayService {
  const ProverbOfDayService();

  /// Local calendar date used for selection (defaults to now).
  DateTime localCalendarDate([DateTime? date]) =>
      _dateOnly((date ?? DateTime.now()).toLocal());

  /// 1-based day index for [date]'s year (Jan 1 = 1), in local time.
  int dayOfYear(DateTime date) {
    final local = _dateOnly(date.toLocal());
    final start = DateTime(local.year, 1, 1);
    return local.difference(start).inDays + 1;
  }

  /// Stable seed per local calendar day (includes year so dates do not repeat yearly).
  int calendarSeed(DateTime date) {
    final local = localCalendarDate(date);
    return local.year * 1000 + dayOfYear(local);
  }

  /// List index for [date] into [proverbs] (same order as [ProverbsRepository.allProverbs]).
  int indexForDate(List<Proverb> proverbs, [DateTime? date]) {
    if (proverbs.isEmpty) return -1;
    return (calendarSeed(date ?? DateTime.now()) - 1) % proverbs.length;
  }

  /// Picks one proverb per local calendar day.
  Proverb? selectForDate(List<Proverb> proverbs, [DateTime? date]) {
    if (proverbs.isEmpty) return null;
    return proverbs[indexForDate(proverbs, date)];
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
