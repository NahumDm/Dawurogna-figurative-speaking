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
    } catch (_) {
      _errorMessage = 'Unable to load proverbs. Please restart the app.';
      _proverbs = [];
    } finally {
      _isLoading = false;
    }
  }

  @override
  List<Proverb> getProverbsByLetter(String letter) {
    final normalized = AlphabetNormalizer.normalize(letter);
    return _proverbs.where((p) => p.letter == normalized).toList();
  }

  @override
  Proverb? getProverbById(String id) {
    for (final proverb in _proverbs) {
      if (proverb.id == id) return proverb;
    }
    return null;
  }
}
