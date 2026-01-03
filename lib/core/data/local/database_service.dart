import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:ramadan_companion/features/quran/data/models/quran_model.dart';
import 'package:ramadan_companion/features/names/data/models/details_model.dart';
import 'package:ramadan_companion/features/prayer_times/data/models/prayer_time_model.dart';

part 'database_service.g.dart';

@Riverpod(keepAlive: true)
DatabaseService databaseService(DatabaseServiceRef ref) {
  return DatabaseService();
}

class DatabaseService {
  late Future<Isar> db;

  DatabaseService() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          DhikrCategorySchema,
          DhikrItemSchema,
          PrayerTimeModelSchema,
          QuranSurahSchema,
          QuranAyahSchema,
          QuranTafseerSchema,
          NameOfAllahSchema,
        ],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
