import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:ramadan_companion/features/adhkar/data/repositories/adhkar_repository.dart';
import 'package:ramadan_companion/features/home/data/repositories/prayer_time_repository.dart';
import 'package:ramadan_companion/features/quran/data/repositories/quran_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerRepo = ref.watch(prayerTimeRepositoryProvider);
    final prayerTimesAsync = ref.watch(prayerTimesProvider);
    final lastReadAsync = ref.watch(lastReadProvider);
    final dailyDhikrAsync = ref.watch(dailyDhikrProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _HomeHeader(),
              const SizedBox(height: 24),
              prayerTimesAsync.when(
                data: (pt) => _MainPrayerCard(
                  prayerName: prayerRepo.getNextPrayerName(pt),
                  prayerTime: prayerRepo.getNextPrayerTime(pt),
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
              dailyDhikrAsync.when(
                data: (item) => _DailyDuaCard(dhikr: item),
                loading: () => const _LoadingCard(height: 120),
                error: (e, s) => const _DailyDuaCard(dhikr: null),
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
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'رمضان كريم',
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'أهلاً، عبد الله',
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

class _MainPrayerCard extends StatelessWidget {
  final String prayerName;
  final DateTime? prayerTime;

  const _MainPrayerCard({required this.prayerName, required this.prayerTime});

  @override
  Widget build(BuildContext context) {
    // Simple countdown logic simulation (for UI purposes)
    const countdown = '02:14:35';

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
              'الصلاة القادمة',
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            prayerName,
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            countdown,
            style: GoogleFonts.manrope(
              color: AppColors.accent,
              fontSize: 48,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'متبقي على رفع الأذان',
            style: GoogleFonts.cairo(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Row(
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
    // In design: الفجر, الظهر, العصر (Active), المغرب

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true, // Arabic RTL flow
      child: Row(
        children: [
          _PrayerSmallCard(name: 'العشاء', time: '19:45', isActive: false),
          const SizedBox(width: 12),
          _PrayerSmallCard(
            name: 'المغرب',
            time: '18:20',
            isActive: false,
            icon: Icons.nights_stay,
          ),
          const SizedBox(width: 12),
          _PrayerSmallCard(
            name: 'العصر',
            time: '15:45',
            isActive: true,
            icon: Icons.wb_sunny,
          ),
          const SizedBox(width: 12),
          _PrayerSmallCard(
            name: 'الظهر',
            time: '12:15',
            isActive: false,
            icon: Icons.wb_sunny_outlined,
          ),
          const SizedBox(width: 12),
          _PrayerSmallCard(
            name: 'الفجر',
            time: '04:33',
            isActive: false,
            icon: Icons.wb_twilight,
          ),
        ],
      ),
    );
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
        color: isActive ? AppColors.primaryDark : Colors.white,
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

class _TasbeehWidget extends StatelessWidget {
  const _TasbeehWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Column(
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
                    'سبحان الله',
                    style: GoogleFonts.cairo(color: Colors.white, fontSize: 14),
                  ),
                ],
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
              '33',
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
              'اضغط للعد',
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
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

    return Container(
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
            'سورة البقرة',
            style: GoogleFonts.cairo(color: AppColors.textMuted, fontSize: 12),
          ),
          Text(
            'صفحة $page',
            style: GoogleFonts.cairo(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _DailyDuaCard extends StatelessWidget {
  final DhikrItem? dhikr;
  const _DailyDuaCard({this.dhikr});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'دعاء اليوم',
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
            dhikr?.text ?? 'اللهم إنك عفو تحب العفو فاعف عنا',
            textAlign: TextAlign.center,
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
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
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
          icon: Icons.compass_calibration_outlined,
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
        _ToolCard(
          title: 'التبرعات',
          icon: Icons.volunteer_activism_outlined,
          color: const Color(0xFFF3E5F5),
          iconColor: Colors.purple,
          onTap: () => context.push('/charity'),
        ),
        _ToolCard(
          title: 'المجتمع',
          icon: Icons.groups_outlined,
          color: const Color(0xFFE3F2FD),
          iconColor: Colors.blue,
          onTap: () => context.push('/community'),
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

final dailyDhikrProvider = FutureProvider<DhikrItem?>((ref) async {
  final repo = ref.watch(adhkarRepositoryProvider);
  final morning = await repo.getMorningAdhkar();
  if (morning.isNotEmpty) {
    return morning[Random().nextInt(morning.length)];
  }
  return null;
});
