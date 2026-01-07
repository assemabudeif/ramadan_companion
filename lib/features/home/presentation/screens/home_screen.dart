import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/features/home/data/repositories/prayer_time_repository.dart';
import 'package:ramadan_companion/features/quran/data/repositories/quran_repository.dart';

import 'package:hijri/hijri_calendar.dart';
import 'package:ramadan_companion/features/settings/data/repositories/user_profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerRepo = ref.watch(prayerTimeRepositoryProvider);
    final prayerTimesAsync = ref.watch(prayerTimesProvider);
    final lastReadAsync = ref.watch(lastReadProvider);
    final dailyWisdomAsync = ref.watch(dailyWisdomProvider);
    final locationNameAsync = ref.watch(locationNameProvider);
    final userNameAsync = ref.watch(userNameProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HomeHeader(userName: userNameAsync.valueOrNull),
              const SizedBox(height: 24),
              prayerTimesAsync.when(
                data: (pt) => _MainPrayerCard(
                  prayerName: prayerRepo.getNextPrayerName(pt),
                  prayerTime: prayerRepo.getNextPrayerTime(pt),
                  locationName: locationNameAsync.valueOrNull,
                ),
                loading: () => const _LoadingCard(height: 200),
                error: (e, s) => const _ErrorCard(),
              ),
              const SizedBox(height: 24),
              prayerTimesAsync.when(
                data: (pt) => _HorizontalPrayerRow(pt: pt, repo: prayerRepo),
                loading: () => const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, s) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: _TasbeehWidget()),
                  const SizedBox(width: 16),
                  Expanded(
                    child: lastReadAsync.when(
                      data: (page) => _KhatmahWidget(page: page),
                      loading: () => const _LoadingCard(height: 150),
                      error: (e, s) => const _KhatmahWidget(page: 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('أدوات وتطبيقات'),
              const SizedBox(height: 16),
              const _QuickToolsGrid(),
              const SizedBox(height: 24),
              dailyWisdomAsync.when(
                data: (item) => _DailyDuaCard(verse: item),
                loading: () => const _LoadingCard(height: 120),
                error: (e, s) => const _DailyDuaCard(verse: null),
              ),
              const SizedBox(height: 80), // Space for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final String? userName;
  const _HomeHeader({this.userName});

  @override
  Widget build(BuildContext context) {
    final hijri = HijriCalendar.now();
    // Simple Arabic formatting or use defaults if locale supported
    // hijri.toFormat('dd MMMM yyyy') -> needs locale
    // For now, custom format string or assume english/mixed is ok, or manual map.
    // Let's rely on basic display "Ramadan 1445" if valid, or just generic.
    // hijri package supports Ar if set.
    HijriCalendar.setLocal('ar');
    final dateStr = hijri.toFormat('dd MMMM yyyy');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => context.push('/settings'),
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.accent.withOpacity(0.2),
                child: const Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              dateStr, // e.g. 01 Ramadan 1445
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'أهلاً، ${userName ?? "عبد الله"}',
              style: GoogleFonts.cairo(
                fontSize: 22,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MainPrayerCard extends StatefulWidget {
  final String prayerName;
  final DateTime? prayerTime;
  final String? locationName;

  const _MainPrayerCard({
    required this.prayerName,
    required this.prayerTime,
    this.locationName,
  });

  @override
  State<_MainPrayerCard> createState() => _MainPrayerCardState();
}

class _MainPrayerCardState extends State<_MainPrayerCard> {
  late Stream<String> _timerStream;

  @override
  void initState() {
    super.initState();
    _timerStream = Stream.periodic(const Duration(seconds: 1), (_) {
      if (widget.prayerTime == null) return '--:--:--';
      final now = DateTime.now();
      final diff = widget.prayerTime!.difference(now);
      if (diff.isNegative) return '00:00:00';

      final hours = diff.inHours.toString().padLeft(2, '0');
      final minutes = (diff.inMinutes % 60).toString().padLeft(2, '0');
      final seconds = (diff.inSeconds % 60).toString().padLeft(2, '0');

      return '$hours:$minutes:$seconds';
    }).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.locationName ?? 'جاري التحديث...',
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.prayerName,
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder<String>(
            stream: _timerStream,
            initialData: '00:00:00',
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? '00:00:00',
                style: GoogleFonts.manrope(
                  color: AppColors.accent,
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            'الصلاة القادمة',
            style: GoogleFonts.cairo(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () => context.push('/calendar'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  'عرض مواقيت اليوم',
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalPrayerRow extends StatelessWidget {
  final dynamic pt; // PrayerTimes object
  final PrayerTimeRepository repo;

  const _HorizontalPrayerRow({required this.pt, required this.repo});

  @override
  Widget build(BuildContext context) {
    // Generate list from PrayerTimes object
    // Assuming pt has getters for each prayer.
    // The design is reversed (RTL), but we can just list them in order and use reverse: true or just list them right-to-left.
    // Order: Isha, Maghrib, Asr, Dhuhr, Fajr (since reverse:true).

    // We need to determine "active" prayer.
    // PrayerTimeRepository likely has 'nextPrayer' or current.
    // Let's assume we want to highlight the *next* prayer as active, or maybe the current one?
    // The main card shows "Next Prayer", so maybe this list shows which one is next too?
    // Or maybe just highlights based on time.

    // For simplicity: calculate 'next' using repo logic if available, or just check next prayer.
    final next = repo.getNextPrayerName(pt); // e.g. 'Fajr', 'Dhuhr' etc.

    // Mapping:
    // Fajr, Sunrise (optional), Dhuhr, Asr, Maghrib, Isha.
    // Let's show the main 5.

    final prayers = [
      {
        'name': 'العشاء',
        'time': _format(pt.isha),
        'key': 'Isha',
        'icon': Icons.nights_stay,
      },
      {
        'name': 'المغرب',
        'time': _format(pt.maghrib),
        'key': 'Maghrib',
        'icon': Icons.wb_twilight,
      },
      {
        'name': 'العصر',
        'time': _format(pt.asr),
        'key': 'Asr',
        'icon': Icons.wb_sunny,
      },
      {
        'name': 'الظهر',
        'time': _format(pt.dhuhr),
        'key': 'Dhuhr',
        'icon': Icons.wb_sunny_outlined,
      },
      {
        'name': 'الفجر',
        'time': _format(pt.fajr),
        'key': 'Fajr',
        'icon': Icons.wb_twilight,
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Row(
        children: prayers.map((p) {
          final isNext = p['name'] == next;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _PrayerSmallCard(
              name: p['name'] as String,
              time: p['time'] as String,
              isActive: isNext, // Highlight the upcoming prayer
              icon: p['icon'] as IconData,
            ),
          );
        }).toList(),
      ),
    );
  }

  String _format(DateTime dt) {
    // Simple formatter. Ideally use intl.
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _PrayerSmallCard extends StatelessWidget {
  final String name;
  final String time;
  final bool isActive;
  final IconData icon;

  const _PrayerSmallCard({
    required this.name,
    required this.time,
    required this.isActive,
    this.icon = Icons.access_time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (!isActive)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          Text(
            name,
            style: GoogleFonts.cairo(
              color: isActive ? Colors.white : AppColors.textMuted,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: GoogleFonts.manrope(
              color: isActive ? Colors.white : AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Icon(
            icon,
            color: isActive ? AppColors.accent : Colors.grey.shade400,
            size: 24,
          ),
        ],
      ),
    );
  }
}

class _TasbeehWidget extends StatefulWidget {
  const _TasbeehWidget();

  @override
  State<_TasbeehWidget> createState() => _TasbeehWidgetState();
}

class _TasbeehWidgetState extends State<_TasbeehWidget> {
  int _counter = 0;
  String _dhikr = 'سبحان الله';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _counter = prefs.getInt('tasbeeh_counter') ?? 0;
        _dhikr = prefs.getString('tasbeeh_dhikr') ?? 'سبحان الله';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.push('/tasbeeh');
        // Reload data when returning from Tasbeeh screen
        _fetchData();
      },
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'التسبيح',
                        style: GoogleFonts.cairo(
                          color: AppColors.accent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _dhikr,
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.refresh, color: AppColors.accent, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 8,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '$_counter',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'اضغط للمتابعة',
                style: GoogleFonts.cairo(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KhatmahWidget extends StatelessWidget {
  final int page;
  const _KhatmahWidget({required this.page});

  @override
  Widget build(BuildContext context) {
    final progress = page / 604.0;
    final percent = (progress * 100).toInt();

    return InkWell(
      onTap: () => context.push('/quran/read/$page'), // Link to last read page
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.book_outlined, color: Colors.grey, size: 20),
                const Spacer(),
                Text(
                  'ختمة القرآن',
                  style: GoogleFonts.cairo(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade100,
                    color: AppColors.accent,
                  ),
                ),
                Text(
                  '$percent%',
                  style: GoogleFonts.manrope(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'تابع القراءة',
              style: GoogleFonts.cairo(
                color: AppColors.textMuted,
                fontSize: 12,
              ),
            ),
            Text(
              'صفحة $page',
              style: GoogleFonts.cairo(
                color: AppColors.textMuted,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyDuaCard extends StatelessWidget {
  final dynamic
  verse; // QuranAyah? but dynamic to avoid importing internal Isar model here if not needed
  const _DailyDuaCard({this.verse});

  @override
  Widget build(BuildContext context) {
    // If verse is null, show a fallback or loading state visually, or just empty.
    // Assuming verse has .text and .surahNumber etc if it's the model.
    // Safe access via dynamic or casting if we import.
    // Let's rely on basic property access.

    final text = verse != null ? verse.text : '...';
    // We might want Surah name too if available, but for now text is key.

    return InkWell(
      onTap: () {
        if (verse != null) {
          // Navigate to that verse PAGE
          context.push('/quran/read/${verse.pageNumber}');
        }
      },
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [Color(0xFFB8860B), Color(0xFF8B4513)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'آية اليوم',
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.amiri(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(Icons.share, color: Colors.white, size: 18),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  final double height;
  const _LoadingCard({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Center(child: Text('خطأ في تحميل البيانات')),
    );
  }
}

class _QuickToolsGrid extends StatelessWidget {
  const _QuickToolsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _ToolCard(
          title: 'القبلة',
          icon: Icons.explore_outlined,
          color: const Color(0xFFE8F5E9),
          iconColor: Colors.green,
          onTap: () => context.push('/qibla'),
        ),
        _ToolCard(
          title: 'الزكاة',
          icon: Icons.calculate_outlined,
          color: const Color(0xFFFFF3E0),
          iconColor: Colors.orange,
          onTap: () => context.push('/zakat'),
        ),
        // _ToolCard(
        //   title: 'التبرعات',
        //   icon: Icons.volunteer_activism_outlined,
        //   color: const Color(0xFFF3E5F5),
        //   iconColor: Colors.purple,
        //   onTap: () => context.push('/charity'),
        // ),
        // _ToolCard(
        //   title: 'المجتمع',
        //   icon: Icons.groups_outlined,
        //   color: const Color(0xFFE3F2FD),
        //   iconColor: Colors.blue,
        //   onTap: () => context.push('/community'),
        // ),
        _ToolCard(
          title: 'الإمساكية',
          icon: Icons.calendar_month_outlined,
          color: const Color(0xFFFCE4EC),
          iconColor: Colors.pink,
          onTap: () => context.push('/imsakia'),
        ),
        _ToolCard(
          title: 'المسبحة',
          icon: Icons.touch_app_outlined,
          color: const Color(0xFFE0F2F1),
          iconColor: Colors.teal,
          onTap: () => context.push('/tasbeeh'),
        ),
        _ToolCard(
          title: 'الأسماء',
          icon: Icons.auto_awesome_outlined,
          color: const Color(0xFFFFF9C4),
          iconColor: Colors.amber,
          onTap: () => context.push('/names-of-allah'),
        ),
        _ToolCard(
          title: 'المساعد',
          icon: Icons.auto_fix_high_outlined,
          color: const Color(0xFFF1F8E9),
          iconColor: Colors.lightGreen,
          onTap: () => context.push('/assistant'),
        ),
      ],
    );
  }
}

class _ToolCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _ToolCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final prayerTimesProvider = FutureProvider((ref) async {
  final repo = ref.watch(prayerTimeRepositoryProvider);
  return repo.getPrayerTimes();
});

final lastReadProvider = FutureProvider((ref) async {
  final repo = ref.watch(quranRepositoryProvider);
  return repo.getLastReadPage();
});

final dailyWisdomProvider = FutureProvider((ref) async {
  final repo = ref.watch(quranRepositoryProvider);
  return repo.getRandomAyah();
});

final locationNameProvider = FutureProvider((ref) async {
  final repo = ref.watch(prayerTimeRepositoryProvider);
  return repo.getLocationName();
});
