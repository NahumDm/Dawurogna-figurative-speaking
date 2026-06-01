import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/data/repositories/proverbs_repository.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/data/favorite_repository.dart';
import 'package:flutter/foundation.dart';

/// Manages favorite proverb IDs and resolves them to [Proverb] models.
class FavoritesController extends ChangeNotifier {
  FavoritesController({
    required FavoriteRepository favoriteRepository,
    required ProverbsRepository proverbsRepository,
  })  : _favoriteRepository = favoriteRepository,
        _proverbsRepository = proverbsRepository;

  final FavoriteRepository _favoriteRepository;
  final ProverbsRepository _proverbsRepository;

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  int get favoriteCount => _favoriteRepository.favoriteIds.length;

  bool isFavorite(String proverbId) =>
      _favoriteRepository.isFavorite(proverbId);

  List<Proverb> get favoriteProverbs {
    final ids = _favoriteRepository.favoriteIds;
    if (ids.isEmpty) return const [];

    final byId = {
      for (final proverb in _proverbsRepository.allProverbs) proverb.id: proverb,
    };

    final resolved = <Proverb>[];
    for (final id in ids) {
      final proverb = byId[id];
      if (proverb != null) resolved.add(proverb);
    }

    resolved.sort((a, b) => a.sortKey.compareTo(b.sortKey));

    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return resolved;

    return resolved
        .where(
          (proverb) =>
              proverb.dawuro.toLowerCase().contains(query) ||
              proverb.phonetic.toLowerCase().contains(query) ||
              proverb.amharic.toLowerCase().contains(query),
        )
        .toList();
  }

  Future<bool> toggleFavorite(String proverbId) async {
    final isNowFavorite = await _favoriteRepository.toggle(proverbId);
    notifyListeners();
    return isNowFavorite;
  }

  Future<void> removeFavorite(String proverbId) async {
    if (!_favoriteRepository.isFavorite(proverbId)) return;
    await _favoriteRepository.remove(proverbId);
    notifyListeners();
  }

  void updateSearch(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() => updateSearch('');
}
