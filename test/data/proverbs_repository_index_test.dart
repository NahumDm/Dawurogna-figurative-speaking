import 'package:dawurogna_figurative_speaking/data/datasource/proverbs_local_datasource.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/data/repositories/proverbs_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeDataSource extends ProverbsLocalDataSource {
  _FakeDataSource(this._items);

  final List<Proverb> _items;

  @override
  Future<List<Proverb>> loadProverbs() async => _items;
}

void main() {
  test('repository indexes proverb counts and lookups', () async {
    final repository = ProverbsRepositoryImpl(
      localDataSource: _FakeDataSource([
        const Proverb(
          id: 'a1',
          letter: 'A',
          dawuro: 'one',
          phonetic: 'one',
          amharic: 'one',
        ),
        const Proverb(
          id: 'a2',
          letter: 'A',
          dawuro: 'two',
          phonetic: 'two',
          amharic: 'two',
        ),
        const Proverb(
          id: 'b1',
          letter: 'B',
          dawuro: 'bee',
          phonetic: 'bee',
          amharic: 'bee',
        ),
      ]),
    );

    await repository.loadProverbs();

    expect(repository.proverbCountForLetter('A'), 2);
    expect(repository.proverbCountForLetter('B'), 1);
    expect(repository.getProverbById('a2')?.dawuro, 'two');
    expect(repository.getProverbsByLetter('A'), hasLength(2));
    expect(repository.getProverbById('missing'), isNull);
  });
}
