import 'package:adhan/adhan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prayer_time_repository.g.dart';

@Riverpod(keepAlive: true)
PrayerTimeRepository prayerTimeRepository(PrayerTimeRepositoryRef ref) {
  return PrayerTimeRepository();
}

class PrayerTimeRepository {
  Future<PrayerTimes> getPrayerTimes() async {
    // TODO: Get real location. For MVP, using Cairo.
    final myCoordinates = Coordinates(30.0444, 31.2357);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    final date = DateComponents.from(DateTime.now());
    return PrayerTimes(myCoordinates, date, params);
  }

  String getNextPrayerName(PrayerTimes prayerTimes) {
    final next = prayerTimes.nextPrayer();
    switch (next) {
      case Prayer.fajr:
        return 'الفجر';
      case Prayer.sunrise:
        return 'الشروق';
      case Prayer.dhuhr:
        return 'الظهر';
      case Prayer.asr:
        return 'العصر';
      case Prayer.maghrib:
        return 'المغرب';
      case Prayer.isha:
        return 'العشاء';
      case Prayer.none:
        return 'الفجر'; // Loop back to next day
    }
  }

  DateTime? getNextPrayerTime(PrayerTimes prayerTimes) {
    return prayerTimes.timeForPrayer(prayerTimes.nextPrayer());
  }
}
