import 'package:isar/isar.dart';

part 'quran_model.g.dart';

@collection
class QuranSurah {
  Id id = Isar.autoIncrement; // Will match the Surah number (1-114)

  @Index(unique: true)
  late int number; // 1-114

  late String nameAr;
  late String nameEn;
  late String type; // Makkiyah / Madaniyah

  late int totalVerses;
  int? revelationOrder;

  @Backlink(to: 'surah')
  final ayahs = IsarLinks<QuranAyah>();
}

@collection
class QuranAyah {
  Id id = Isar.autoIncrement;

  late int numberInSurah; // Verse number (1, 2, 3...)
  late String text; // The Arabic text

  @Index()
  late int surahNumber; // 1-114 (Denormalized)

  @Index()
  late int pageNumber; // Mus'haf Page

  @Index()
  final surah = IsarLink<QuranSurah>();
}

@collection
class QuranTafseer {
  Id id = Isar.autoIncrement;

  late String edition; // e.g., 'ar_muyassar'
  late String text;

  @Index()
  late int surahNumber;

  @Index()
  late int ayahNumber;

  @Index()
  final ayah = IsarLink<QuranAyah>();
}
