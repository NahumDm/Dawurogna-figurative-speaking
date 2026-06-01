import 'package:hive_flutter/hive_flutter.dart';

/// Local persistence for favorite proverb IDs (offline, no duplicates).
abstract class FavoriteRepository {
  Future<void> init();

  Set<String> get favoriteIds;

  bool isFavorite(String proverbId);

  /// Returns `true` if the proverb is now favorited.
  Future<bool> toggle(String proverbId);

  Future<void> remove(String proverbId);
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl({this.boxName = 'favorite_proverb_ids'});

  final String boxName;
  Box<String>? _box;

  @override
  Future<void> init() async {
    if (Hive.isBoxOpen(boxName)) {
      _box = Hive.box<String>(boxName);
      return;
    }
    _box = await Hive.openBox<String>(boxName);
  }

  Box<String> get _requireBox {
    final box = _box;
    if (box == null || !box.isOpen) {
      throw StateError('FavoriteRepository.init() must be called first.');
    }
    return box;
  }

  @override
  Set<String> get favoriteIds => _requireBox.keys.cast<String>().toSet();

  @override
  bool isFavorite(String proverbId) => _requireBox.containsKey(proverbId);

  @override
  Future<bool> toggle(String proverbId) async {
    final box = _requireBox;
    if (box.containsKey(proverbId)) {
      await box.delete(proverbId);
      return false;
    }
    await box.put(proverbId, proverbId);
    return true;
  }

  @override
  Future<void> remove(String proverbId) async {
    await _requireBox.delete(proverbId);
  }
}
