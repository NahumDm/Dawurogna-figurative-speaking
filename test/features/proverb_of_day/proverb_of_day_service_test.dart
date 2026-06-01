import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/features/proverb_of_day/services/proverb_of_day_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = ProverbOfDayService();

  final proverbs = List.generate(
    5,
    (index) => Proverb(
      id: '$index',
      letter: 'A',
      dawuro: 'Proverb $index',
      phonetic: 'p$index',
      amharic: 'a$index',
    ),
  );

  test('returns same proverb throughout the same day', () {
    final day = DateTime(2026, 3, 15);
    final first = service.selectForDate(proverbs, day);
    final second = service.selectForDate(proverbs, day);

    expect(first, isNotNull);
    expect(second?.id, first?.id);
  });

  test('changes proverb on the next day', () {
    final dayOne = DateTime(2026, 3, 15);
    final dayTwo = DateTime(2026, 3, 16);

    final first = service.selectForDate(proverbs, dayOne);
    final next = service.selectForDate(proverbs, dayTwo);

    expect(first, isNotNull);
    expect(next, isNotNull);
    expect(next!.id, isNot(first!.id));
  });

  test('uses dayOfYear modulo total proverbs', () {
    final day = DateTime(2026, 1, 10);
    final index = service.dayOfYear(day) - 1;
    final expected = proverbs[index % proverbs.length];

    expect(service.selectForDate(proverbs, day)?.id, expected.id);
  });

  test('opens deterministic index for known date', () {
    final day = DateTime(2026, 6, 2);
    final proverb = service.selectForDate(proverbs, day);
    expect(proverb, isNotNull);
    expect(proverbs.map((p) => p.id), contains(proverb!.id));
  });
}
