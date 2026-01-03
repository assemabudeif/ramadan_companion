import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/core/data/local/database_service.dart';
import 'package:ramadan_companion/features/quran/data/models/quran_model.dart';

part 'quran_repository.g.dart';

@Riverpod(keepAlive: true)
QuranRepository quranRepository(QuranRepositoryRef ref) {
  return QuranRepository(ref.watch(databaseServiceProvider));
}

class QuranRepository {
  final DatabaseService _dbService;

  QuranRepository(this._dbService);

  /// Get list of all Surahs (for Index)
  Future<List<QuranSurah>> getAllSurahs() async {
    final isar = await _dbService.db;
    return isar.collection<QuranSurah>().where().sortByNumber().findAll();
  }

  /// Get specific Surah by number (1-114)
  Future<QuranSurah?> getSurahByNumber(int number) async {
    final isar = await _dbService.db;
    return isar
        .collection<QuranSurah>()
        .filter()
        .numberEqualTo(number)
        .findFirst();
  }

  /// Get all Ayahs for a specific Surah
  Future<List<QuranAyah>> getAyahsBySurah(int surahNumber) async {
    final surah = await getSurahByNumber(surahNumber);
    if (surah == null) return [];

    // We can load via the link or query
    await surah.ayahs.load();
    // Ensure they are sorted by verse number
    final sortedAyahs = surah.ayahs.toList()
      ..sort((a, b) => a.numberInSurah.compareTo(b.numberInSurah));
    return sortedAyahs;
  }

  /// Get Ayahs by Page (Mushaf)
  Future<List<QuranAyah>> getAyahsByPage(int page) async {
    final isar = await _dbService.db;
    return isar
        .collection<QuranAyah>()
        .filter()
        .pageNumberEqualTo(page)
        .sortBySurahNumber()
        .thenByNumberInSurah()
        .findAll();
  }

  /// Search verses
  Future<List<QuranAyah>> searchVerses(String query) async {
    final isar = await _dbService.db;
    return isar.collection<QuranAyah>().filter().textContains(query).findAll();
  }

  /// Get Tafseer for a specific Verse
  Future<QuranTafseer?> getTafseer(int surah, int ayah) async {
    final isar = await _dbService.db;
    return isar
        .collection<QuranTafseer>()
        .filter()
        .surahNumberEqualTo(surah)
        .and()
        .ayahNumberEqualTo(ayah)
        .findFirst();
  }
}

// Extension to help Sort by Surah link for sorting method above if needed
// Actually we can just sort in memory:
extension AyahSorting on List<QuranAyah> {
  void sortByOrder() {
    sort((a, b) {
      // Need to load surah or use surah ID from link
      // Isar Link doesn't expose ID synchronously easily without load.
      // Assuming page request returns verses from same or sequential surahs.
      // For now, simpler: sort by ID. ID is auto-increment and we seeded sequentially!
      return a.id.compareTo(b.id);
    });
  }
}
