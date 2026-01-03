import 'package:hijri/hijri_calendar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hijri_repository.g.dart';

@Riverpod(keepAlive: true)
HijriRepository hijriRepository(HijriRepositoryRef ref) {
  return HijriRepository();
}

class HijriRepository {
  HijriRepository() {
    HijriCalendar.setLocal('ar');
  }

  String getFormattedHijriDate() {
    final today = HijriCalendar.now();
    return today.toFormat('dd MMMM yyyy');
  }
}
