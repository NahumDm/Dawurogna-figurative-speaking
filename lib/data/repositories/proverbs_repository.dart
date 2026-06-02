import 'package:dawurogna_figurative_speaking/core/utils/alphabet_normalizer.dart';
import 'package:dawurogna_figurative_speaking/data/datasource/proverbs_local_datasource.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';

/// Data access contract for proverbs. Remote sync and favorites can extend this
/// interface without changing UI code.
abstract class ProverbsRepository {
  Future<void> loadProverbs();

  List<Proverb> get allProverbs;

  bool get isLoading;

  String? get errorMessage;

  List<Proverb> getProverbsByLetter(String letter);

  int proverbCountForLetter(String letter);

  Proverb? getProverbById(String id);

  // Future-ready hooks (not implemented yet):
  // Future<List<Proverb>> getFavoriteProverbs();
  // Future<void> toggleFavorite(String proverbId);
}

class ProverbsRepositoryImpl implements ProverbsRepository {
  ProverbsRepositoryImpl({ProverbsLocalDataSource? localDataSource})
    : _localDataSource = localDataSource ?? ProverbsLocalDataSource();

  final ProverbsLocalDataSource _localDataSource;

  List<Proverb> _proverbs = [];
  Map<String, Proverb> _byId = {};
  Map<String, List<Proverb>> _byLetter = {};
  Map<String, int> _countByLetter = {};
  bool _isLoading = false;
  String? _errorMessage;

  @override
  List<Proverb> get allProverbs => List.unmodifiable(_proverbs);

  @override
  bool get isLoading => _isLoading;

  @override
  String? get errorMessage => _errorMessage;

  @override
  Future<void> loadProverbs() async {
    if (_proverbs.isNotEmpty || _isLoading) return;

    _isLoading = true;
    _errorMessage = null;

    try {
      final loaded = await _localDataSource.loadProverbs();
      loaded.sort((a, b) => a.sortKey.compareTo(b.sortKey));
      _proverbs = loaded;
      _buildIndexes();
    } catch (_) {
      _errorMessage = 'Unable to load proverbs. Please restart the app.';
      _proverbs = [];
      _clearIndexes();
    } finally {
      _isLoading = false;
    }
  }

  void _buildIndexes() {
    _byId = {for (final proverb in _proverbs) proverb.id: proverb};
    _byLetter = {};
    _countByLetter = {};
    for (final proverb in _proverbs) {
      final list = _byLetter.putIfAbsent(proverb.letter, () => []);
      list.add(proverb);
    }
    for (final entry in _byLetter.entries) {
      _countByLetter[entry.key] = entry.value.length;
    }
  }

  void _clearIndexes() {
    _byId = {};
    _byLetter = {};
    _countByLetter = {};
  }

  @override
  List<Proverb> getProverbsByLetter(String letter) {
    final normalized = AlphabetNormalizer.normalize(letter);
    final list = _byLetter[normalized];
    if (list != null) return List.unmodifiable(list);
    return const [];
  }

  @override
  int proverbCountForLetter(String letter) {
    final normalized = AlphabetNormalizer.normalize(letter);
    return _countByLetter[normalized] ?? 0;
  }

  @override
  Proverb? getProverbById(String id) => _byId[id];
}
