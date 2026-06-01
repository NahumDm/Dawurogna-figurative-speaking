import 'dart:io';

import 'package:dawurogna_figurative_speaking/features/favorites/data/favorite_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  late Directory tempDir;
  late FavoriteRepositoryImpl repository;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_favorites_test');
    Hive.init(tempDir.path);
    repository = FavoriteRepositoryImpl(boxName: 'test_favorites_box');
    await repository.init();
  });

  tearDown(() async {
    if (Hive.isBoxOpen('test_favorites_box')) {
      await Hive.box<String>('test_favorites_box').clear();
      await Hive.box<String>('test_favorites_box').close();
    }
    await Hive.deleteBoxFromDisk('test_favorites_box');
    await tempDir.delete(recursive: true);
  });

  test('add favorite and detect duplicate prevention via toggle', () async {
    expect(repository.isFavorite('42'), isFalse);

    final added = await repository.toggle('42');
    expect(added, isTrue);
    expect(repository.isFavorite('42'), isTrue);
    expect(repository.favoriteIds, {'42'});

    final removed = await repository.toggle('42');
    expect(removed, isFalse);
    expect(repository.isFavorite('42'), isFalse);
    expect(repository.favoriteIds, isEmpty);
  });

  test('remove favorite explicitly', () async {
    await repository.toggle('7');
    await repository.remove('7');
    expect(repository.favoriteIds, isEmpty);
  });

  test('persists ids in box across repository instances', () async {
    await repository.toggle('100');
    await Hive.box<String>('test_favorites_box').close();

    final reloaded = FavoriteRepositoryImpl(boxName: 'test_favorites_box');
    await reloaded.init();

    expect(reloaded.isFavorite('100'), isTrue);
    expect(reloaded.favoriteIds, {'100'});
  });
}
