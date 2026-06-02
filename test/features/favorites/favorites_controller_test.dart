import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/data/repositories/proverbs_repository.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/data/favorite_repository.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/favorites_controller.dart';
import 'package:flutter_test/flutter_test.dart';

class _InMemoryFavoriteRepository implements FavoriteRepository {
  final Set<String> _ids = {};

  @override
  Future<void> init() async {}

  @override
  Set<String> get favoriteIds => Set.unmodifiable(_ids);

  @override
  bool isFavorite(String proverbId) => _ids.contains(proverbId);

  @override
  Future<bool> toggle(String proverbId) async {
    if (_ids.contains(proverbId)) {
      _ids.remove(proverbId);
      return false;
    }
    _ids.add(proverbId);
    return true;
  }

  @override
  Future<void> remove(String proverbId) async {
    _ids.remove(proverbId);
  }
}

class _FakeProverbsRepository implements ProverbsRepository {
  _FakeProverbsRepository(this._items);

  final List<Proverb> _items;

  @override
  List<Proverb> get allProverbs => _items;

  @override
  String? get errorMessage => null;

  @override
  bool get isLoading => false;

  @override
  Future<void> loadProverbs() async {}

  @override
  List<Proverb> getProverbsByLetter(String letter) => _items;

  @override
  int proverbCountForLetter(String letter) => _items.length;

  @override
  Proverb? getProverbById(String id) {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }
}

void main() {
  late _InMemoryFavoriteRepository favoriteRepository;
  late FavoritesController controller;

  final proverbs = [
    const Proverb(
      id: '1',
      letter: 'A',
      dawuro: 'Alpha proverb',
      phonetic: 'alpha',
      amharic: 'አልፋ',
    ),
    const Proverb(
      id: '2',
      letter: 'B',
      dawuro: 'Beta proverb',
      phonetic: 'beta',
      amharic: 'ቤታ',
    ),
  ];

  setUp(() {
    favoriteRepository = _InMemoryFavoriteRepository();
    controller = FavoritesController(
      favoriteRepository: favoriteRepository,
      proverbsRepository: _FakeProverbsRepository(proverbs),
    );
  });

  test('add and remove favorite updates list', () async {
    await controller.toggleFavorite('1');
    expect(controller.favoriteProverbs, hasLength(1));
    expect(controller.isFavorite('1'), isTrue);

    await controller.removeFavorite('1');
    expect(controller.favoriteProverbs, isEmpty);
  });

  test('no duplicate favorites when toggled twice', () async {
    await controller.toggleFavorite('2');
    await controller.toggleFavorite('2');
    expect(controller.favoriteProverbs, isEmpty);
  });

  test('search filters favorites', () async {
    await controller.toggleFavorite('1');
    await controller.toggleFavorite('2');

    controller.updateSearch('Beta');
    expect(controller.favoriteProverbs, hasLength(1));
    expect(controller.favoriteProverbs.first.id, '2');
  });
}
