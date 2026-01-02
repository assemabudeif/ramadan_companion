import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/core/data/local/database_service.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:isar/isar.dart';

part 'sync_service.g.dart';

@Riverpod(keepAlive: true)
SyncService syncService(SyncServiceRef ref) {
  return SyncService(ref.watch(databaseServiceProvider));
}

class SyncService {
  final DatabaseService _dbService;

  SyncService(this._dbService);

  /// Seeds the database with initial offline data if empty
  Future<void> seedInitialData() async {
    final isar = await _dbService.db;

    // Check if data exists
    final count = await isar.dhikrItems.count();
    if (count > 0) return;

    // Seed Data
    await isar.writeTxn(() async {
      // 1. Morning Adhkar
      final morningCat = DhikrCategory()..name = 'أذكار الصباح';
      await isar.dhikrCategories.put(morningCat);

      final item1 = DhikrItem()
        ..text = "اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ..."
        ..reference = "آية الكرسي"
        ..targetCount = 1
        ..category.value = morningCat;

      final item2 = DhikrItem()
        ..text = "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ..."
        ..reference = "سيد الاستغفار"
        ..targetCount = 3
        ..category.value = morningCat;

      await isar.dhikrItems.putAll([item1, item2]);
      await item1.category.save();
      await item2.category.save();

      // 2. Evening Adhkar
      final eveningCat = DhikrCategory()..name = 'أذكار المساء';
      await isar.dhikrCategories.put(eveningCat);

      final item3 = DhikrItem()
        ..text = "أَمْسَيْـنا وَأَمْسـى المـلكُ لله وَالحَمدُ لله..."
        ..reference = "الذكر"
        ..targetCount = 1
        ..category.value = eveningCat;

      await isar.dhikrItems.put(item3);
      await item3.category.save();
    });
  }
}
