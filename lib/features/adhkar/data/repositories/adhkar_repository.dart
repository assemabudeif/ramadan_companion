import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/core/data/local/database_service.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';

part 'adhkar_repository.g.dart';

@Riverpod(keepAlive: true)
AdhkarRepository adhkarRepository(AdhkarRepositoryRef ref) {
  return AdhkarRepository(ref.watch(databaseServiceProvider));
}

class AdhkarRepository {
  final DatabaseService _dbService;

  AdhkarRepository(this._dbService);

  /// Get all available categories
  Future<List<DhikrCategory>> getCategories() async {
    final isar = await _dbService.db;
    return isar.collection<DhikrCategory>().where().findAll();
  }

  /// Get Adhkar by Category Name (e.g., 'أذكار الصباح')
  Future<DhikrCategory?> getCategoryByName(String name) async {
    final isar = await _dbService.db;
    return isar
        .collection<DhikrCategory>()
        .filter()
        .nameEqualTo(name)
        .findFirst();
  }

  /// Get Adhkar Items for a specific Category ID
  Future<List<DhikrItem>> getAdhkarByCategory(int categoryId) async {
    final isar = await _dbService.db;
    return isar
        .collection<DhikrItem>()
        .filter()
        .category((q) => q.idEqualTo(categoryId))
        .findAll();
  }

  /// Get items for specific well-known categories directly
  Future<List<DhikrItem>> getMorningAdhkar() async {
    final cat = await getCategoryByName('أذكار الصباح');
    if (cat == null) return [];
    // Load items linked to this category
    // Note: IsarLinks are lazy, but we can query using the backlink or the relationship query above
    return getAdhkarByCategory(cat.id);
  }

  Future<List<DhikrItem>> getEveningAdhkar() async {
    final cat = await getCategoryByName('أذكار المساء');
    if (cat == null) return [];
    return getAdhkarByCategory(cat.id);
  }

  /// Toggle Favorite Status
  Future<void> toggleFavorite(int itemId) async {
    final isar = await _dbService.db;
    await isar.writeTxn(() async {
      final item = await isar.collection<DhikrItem>().get(itemId);
      if (item != null) {
        item.isFavorite = !item.isFavorite;
        await isar.collection<DhikrItem>().put(item);
      }
    });
  }

  /// Get Favorite Adhkar
  Future<List<DhikrItem>> getFavoriteAdhkar() async {
    final isar = await _dbService.db;
    return isar
        .collection<DhikrItem>()
        .filter()
        .isFavoriteEqualTo(true)
        .findAll();
  }

  /// Search Adhkar
  Future<List<DhikrItem>> searchAdhkar(String query) async {
    final isar = await _dbService.db;
    return isar.collection<DhikrItem>().filter().textContains(query).findAll();
  }
}
