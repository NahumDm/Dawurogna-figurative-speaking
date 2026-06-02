import 'package:dawurogna_figurative_speaking/data/datasource/proverbs_local_datasource.dart';
import 'package:dawurogna_figurative_speaking/features/proverb_of_day/services/proverb_of_day_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const service = ProverbOfDayService();

  test('real corpus: consecutive calendar days pick different proverbs', () async {
    final loaded = await ProverbsLocalDataSource().loadProverbs();
    loaded.sort((a, b) => a.sortKey.compareTo(b.sortKey));
    expect(loaded.length, greaterThan(1));

    final yesterday = DateTime(2026, 6, 1);
    final today = DateTime(2026, 6, 2);

    final podYesterday = service.selectForDate(loaded, yesterday);
    final podToday = service.selectForDate(loaded, today);

    expect(podYesterday, isNotNull);
    expect(podToday, isNotNull);
    expect(
      podToday!.id,
      isNot(podYesterday!.id),
      reason:
          'June 1 vs June 2 should not share proverb of the day (indices '
          '${service.indexForDate(loaded, yesterday)} vs '
          '${service.indexForDate(loaded, today)} of ${loaded.length})',
    );
  });
}
