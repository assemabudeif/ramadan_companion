import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/core/data/local/database_service.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:ramadan_companion/features/quran/data/models/quran_model.dart';
import 'package:ramadan_companion/features/names/data/models/details_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

part 'sync_service.g.dart';

@Riverpod(keepAlive: true)
SyncService syncService(SyncServiceRef ref) {
  return SyncService(ref.watch(databaseServiceProvider));
}

class SyncService {
  final DatabaseService _dbService;
  final AssetBundle _assetBundle;

  SyncService(this._dbService) : _assetBundle = rootBundle;

  /// Main method to trigger all seeding
  Future<void> seedAllData() async {
    await seedAdhkarData();
    await seedQuranData();
    await seedNamesData();
  }

  /// Seeds Adhkar (Existing logic)
  Future<void> seedAdhkarData() async {
    final isar = await _dbService.db;
    final count = await isar.collection<DhikrItem>().count();
    if (count > 0) return;

    try {
      print('Seeding Adhkar (New JSON)...');
      final jsonString = await _assetBundle.loadString('assets/azkar.json');
      final jsonData = json.decode(jsonString) as List<dynamic>;

      await isar.writeTxn(() async {
        final Map<String, DhikrCategory> categoryMap = {};

        for (final itemJson in jsonData) {
          // New format: {category, zekr, description, count, reference, search}
          final categoryName = itemJson['category'] as String;
          final zekrText = itemJson['zekr'] as String;
          final description = itemJson['description']?.toString() ?? '';
          final reference = itemJson['reference']?.toString() ?? '';

          // Count handling
          int targetCount = 1;
          final countRaw = itemJson['count'];
          if (countRaw is int) {
            targetCount = countRaw;
          } else if (countRaw is String && countRaw.isNotEmpty) {
            targetCount = int.tryParse(countRaw) ?? 1;
          }

          DhikrCategory? category = categoryMap[categoryName];
          if (category == null) {
            category = DhikrCategory()..name = categoryName;
            await isar.collection<DhikrCategory>().put(category);
            categoryMap[categoryName] = category;
          }

          final item = DhikrItem()
            ..text = zekrText
            ..reference = reference
            ..description = description
            ..virtue =
                description // Use description as virtue
            ..targetCount = targetCount
            ..category.value = category;

          await isar.collection<DhikrItem>().put(item);
          await item.category.save();
        }
      });
      print('Adhkar Seeding Complete.');
    } catch (e) {
      print('Error seeding Adhkar: $e');
    }
  }

  /// Seeds Quran Data (Metadata, Pages, Verses, Tafseer)
  Future<void> seedQuranData() async {
    final isar = await _dbService.db;
    final count = await isar.collection<QuranSurah>().count();
    // Check if we need to seed. For now check Surahs.
    if (count > 0) {
      // Check Tafseer existence too
      if (await isar.collection<QuranTafseer>().count() == 0) {
        await seedTafseerData();
      }
      return;
    }

    try {
      print('Seeding Quran Metadata & Pages...');

      // 0. Load Page Mapping
      final pageString = await _assetBundle.loadString(
        'assets/quran/quran_metadata/page.json',
      );
      final pageJson = json.decode(pageString) as List<dynamic>;
      // Map<VerseKey, PageNumber>. Key format: "Surah:Verse" e.g., "1:1"
      final Map<String, int> verseToPage = {};

      for (final p in pageJson) {
        final pageNum = int.parse(p['index'].toString());
        final startSurah = int.parse(p['start']['index'].toString());
        final startVerse = int.parse(
          p['start']['verse'].toString().split('_')[1],
        );

        final endSurah = int.parse(p['end']['index'].toString());
        final endVerse = int.parse(p['end']['verse'].toString().split('_')[1]);

        if (startSurah == endSurah) {
          for (int v = startVerse; v <= endVerse; v++) {
            verseToPage['$startSurah:$v'] = pageNum;
          }
        } else {
          // Handle cross-surah boundary if needed.
        }
      }

      // 1. Load Surah Metadata
      final metadataString = await _assetBundle.loadString(
        'assets/quran/quran_metadata/surah.json',
      );
      final metadataJson = json.decode(metadataString) as List<dynamic>;

      await isar.writeTxn(() async {
        for (final surahData in metadataJson) {
          final number = int.parse(surahData['index'].toString());
          final nameAr = surahData['titleAr'] as String;
          final nameEn = surahData['title'] as String;
          final type = surahData['type'] as String;
          final totalVerses = surahData['count'] as int;

          final surah = QuranSurah()
            ..number = number
            ..nameAr = nameAr
            ..nameEn = nameEn
            ..type = type
            ..totalVerses = totalVerses
            ..revelationOrder = surahData['revelationOrder'] as int?;

          await isar.collection<QuranSurah>().put(surah);
        }
      });

      print('Seeding Quran Verses (114 Surahs)...');

      for (int i = 1; i <= 114; i++) {
        final surahIndex = i;
        final surahId =
            (await isar
                    .collection<QuranSurah>()
                    .filter()
                    .numberEqualTo(surahIndex)
                    .findFirst())
                ?.id;

        if (surahId == null) continue;
        final surahObj = await isar.collection<QuranSurah>().get(surahId);

        try {
          final fileName = 'assets/quran/quran_suras/surah_$i.json';
          final surahJsonStr = await _assetBundle.loadString(fileName);
          final surahJson = json.decode(surahJsonStr) as Map<String, dynamic>;
          final versesMap = surahJson['verse'] as Map<String, dynamic>;

          await isar.writeTxn(() async {
            final sortedKeys = versesMap.keys.toList()
              ..sort((a, b) {
                final aNum = int.parse(a.split('_')[1]);
                final bNum = int.parse(b.split('_')[1]);
                return aNum.compareTo(bNum);
              });

            for (final key in sortedKeys) {
              final verseNum = int.parse(key.split('_')[1]);
              final text = versesMap[key] as String;

              // Page Lookup
              int pageNum = verseToPage['$i:$verseNum'] ?? 0;

              final ayah = QuranAyah()
                ..numberInSurah = verseNum
                ..text = text
                ..surahNumber =
                    i // Correctly populated now
                ..pageNumber = pageNum
                ..surah.value = surahObj;

              await isar.collection<QuranAyah>().put(ayah);
              await ayah.surah.save();
            }
          });
        } catch (e) {
          print('Error loading Surah $i: $e');
        }
      }
      print('Quran Seeding Complete.');

      await seedTafseerData();
    } catch (e) {
      print('Error seeding Quran: $e');
    }
  }

  Future<void> seedTafseerData() async {
    final isar = await _dbService.db;
    if (await isar.collection<QuranTafseer>().count() > 0) return;

    try {
      print('Seeding Tafseer (Al-Muyassar)...');
      final tafseerStr = await _assetBundle.loadString(
        'assets/quran/tafaseer/ar_muyassar.json',
      );
      final tafseerJson = json.decode(tafseerStr) as List<dynamic>;

      await isar.writeTxn(() async {
        for (final item in tafseerJson) {
          final surahNum = item['sura'] as int;
          final ayahNum = item['aya'] as int;
          final text = item['text'] as String;

          final tf = QuranTafseer()
            ..edition = 'ar_muyassar'
            ..surahNumber = surahNum
            ..ayahNumber = ayahNum
            ..text = text;

          await isar.collection<QuranTafseer>().put(tf);
        }
      });
      print('Tafseer Seeding Complete.');
    } catch (e) {
      print('Error seeding Tafseer: $e');
    }
  }

  /// Seeds Names (New)
  Future<void> seedNamesData() async {
    final isar = await _dbService.db;
    if (await isar.collection<NameOfAllah>().count() > 0) return;

    try {
      print('Seeding Names of Allah...');
      final jsonStr = await _assetBundle.loadString(
        'assets/quran/names_of_allah.json',
      );
      final jsonObj = json.decode(jsonStr) as Map<String, dynamic>;
      final list = jsonObj['data'] as List<dynamic>;

      await isar.writeTxn(() async {
        for (final item in list) {
          final nameStr = item['name'] as String;
          final nameObj = NameOfAllah()..name = nameStr;
          await isar.collection<NameOfAllah>().put(nameObj);
        }
      });
      print('Names Seeding Complete.');
    } catch (e) {
      print('Error seeding Names: $e');
    }
  }
}
