import 'package:isar/isar.dart';

part 'prayer_time_model.g.dart';

@collection
class PrayerTimeModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  late DateTime fajr;
  late DateTime sunrise;
  late DateTime dhuhr;
  late DateTime asr;
  late DateTime maghrib;
  late DateTime isha;

  // Optional: Hijri date string if needed locally
  String? hijriDate;
}
