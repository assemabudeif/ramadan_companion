import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/features/home/data/repositories/prayer_time_repository.dart';

class PrayerCalendarScreen extends ConsumerStatefulWidget {
  const PrayerCalendarScreen({super.key});

  @override
  ConsumerState<PrayerCalendarScreen> createState() =>
      _PrayerCalendarScreenState();
}

class _PrayerCalendarScreenState extends ConsumerState<PrayerCalendarScreen> {
  Coordinates? _coordinates;
  String _locationName = 'جاري التحديث...';
  late DateTime _startDate;
  late List<DateTime> _days;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ar');
    _startDate = DateTime.now();
    // Default Calendar: Next 30 Days
    _days = List.generate(30, (index) => _startDate.add(Duration(days: index)));
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    final repo = ref.read(prayerTimeRepositoryProvider);
    final coords = await repo.getCurrentCoordinates();
    final name = await repo.getLocationName();
    if (mounted) {
      setState(() {
        _coordinates = coords;
        _locationName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
        ),
        title: Text(
          'التقويم',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildLocationHeader(),
          const SizedBox(height: 16),
          _buildTableHeader(),
          Expanded(
            child: _coordinates == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _days.length,
                    itemBuilder: (context, index) {
                      final date = _days[index];
                      return _buildImsakiaRow(date, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationHeader() {
    HijriCalendar.setLocal('ar');
    final nowHijri = HijriCalendar.fromDate(DateTime.now());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.calendar_month, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _locationName,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  nowHijri.toFormat('MMMM yyyy'),
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _headerText('اليوم', 2), // Date takes more space
          _headerText('فجر', 1),
          _headerText('ظهر', 1),
          _headerText('عصر', 1),
          _headerText('مغرب', 1),
          _headerText('عشاء', 1),
        ],
      ),
    );
  }

  Widget _headerText(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.cairo(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImsakiaRow(DateTime date, int index) {
    final repo = ref.read(prayerTimeRepositoryProvider);
    // Safe force unwrap because list only builds if coords not null
    final times = repo.getPrayerTimesFor(_coordinates!, date);

    final isToday = DateUtils.isSameDay(date, DateTime.now());
    final hijri = HijriCalendar.fromDate(date);

    // Format: "1 Ram" or similar.
    final hijriString = '${hijri.hDay} ${hijri.longMonthName}';
    final gregString = DateFormat(
      'd MMM',
      'ar',
    ).format(date); // Arabic locale if possible, else English

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isToday ? AppColors.accent.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isToday ? Border.all(color: AppColors.accent, width: 1) : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  hijriString,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isToday ? AppColors.primary : Colors.black87,
                  ),
                ),
                Text(
                  gregString,
                  style: GoogleFonts.cairo(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          _rowText(
            DateFormat('h:mm a', 'ar').format(times.fajr),
            1,
            isBold: isToday,
          ),
          _rowText(
            DateFormat('h:mm a', 'ar').format(times.dhuhr),
            1,
            isBold: isToday,
          ),
          _rowText(
            DateFormat('h:mm a', 'ar').format(times.asr),
            1,
            isBold: isToday,
          ),
          _rowText(
            DateFormat('h:mm a', 'ar').format(times.maghrib),
            1,
            isBold: isToday,
          ),
          _rowText(
            DateFormat('h:mm a', 'ar').format(times.isha),
            1,
            isBold: isToday,
          ),
        ],
      ),
    );
  }

  Widget _rowText(String text, int flex, {bool isBold = false}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.cairo(
          fontSize: 10,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isBold ? AppColors.primary : Colors.black87,
        ),
      ),
    );
  }
}
