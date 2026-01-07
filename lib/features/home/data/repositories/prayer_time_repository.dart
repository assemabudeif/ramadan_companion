import 'package:adhan/adhan.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prayer_time_repository.g.dart';

@Riverpod(keepAlive: true)
PrayerTimeRepository prayerTimeRepository(PrayerTimeRepositoryRef ref) {
  return PrayerTimeRepository();
}

class PrayerTimeRepository {
  Future<Coordinates> getCurrentCoordinates() async {
    try {
      final position = await _determinePosition();
      return Coordinates(position.latitude, position.longitude);
    } catch (e) {
      // Fallback to Cairo
      return Coordinates(30.0444, 31.2357);
    }
  }

  PrayerTimes getPrayerTimesFor(Coordinates coordinates, DateTime date) {
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    final dateComponents = DateComponents.from(date);
    return PrayerTimes(coordinates, dateComponents, params);
  }

  Future<PrayerTimes> getPrayerTimes() async {
    final coordinates = await getCurrentCoordinates();
    return getPrayerTimesFor(coordinates, DateTime.now());
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
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
    final next = prayerTimes.nextPrayer();
    if (next != Prayer.none) {
      return prayerTimes.timeForPrayer(next);
    }

    // If none, meaning after Isha, get tomorrow's Fajr
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowDate = DateComponents.from(tomorrow);
    final tomorrowPrayers = PrayerTimes(
      prayerTimes.coordinates,
      tomorrowDate,
      prayerTimes.calculationParameters,
    );
    return tomorrowPrayers.fajr;
  }

  Future<String> getLocationName() async {
    try {
      final position = await _determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.locality ?? place.subAdministrativeArea}, ${place.country}';
      }
    } catch (e) {
      // Ignore
    }
    return 'القاهرة، مصر';
  }
}
