import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:ramadan_companion/features/adhkar/data/repositories/adhkar_repository.dart';
import 'package:ramadan_companion/features/home/data/repositories/hijri_repository.dart';
import 'package:ramadan_companion/features/home/data/repositories/prayer_time_repository.dart';
import 'package:ramadan_companion/features/quran/data/repositories/quran_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Hijri Date
    final hijriRepo = ref.watch(hijriRepositoryProvider);
    final hijriDate = hijriRepo.getFormattedHijriDate();

    // 2. Prayer Times
    final prayerRepo = ref.watch(prayerTimeRepositoryProvider);
    final prayerTimesAsync = ref.watch(prayerTimesProvider);

    // 3. Last Read
    final lastReadAsync = ref.watch(lastReadProvider);

    // 4. Daily Dhikr (Random from Morning/Evening for now)
    final dailyDhikrAsync = ref.watch(dailyDhikrProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('رمضان'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Card
            _buildInfoCard(
              context,
              title: 'التاريخ الهجري',
              content: hijriDate,
              icon: Icons.calendar_today,
            ),
            const SizedBox(height: 16),

            // Prayer Time Card
            prayerTimesAsync.when(
              data: (pt) {
                final nextPrayerName = prayerRepo.getNextPrayerName(pt);
                final nextTime = prayerRepo.getNextPrayerTime(pt);
                final timeStr = nextTime != null
                    ? "${nextTime.hour}:${nextTime.minute.toString().padLeft(2, '0')}"
                    : "--:--";
                return _buildInfoCard(
                  context,
                  title: 'الصلاة القادمة: $nextPrayerName',
                  content: timeStr,
                  icon: Icons.access_time,
                );
              },
              loading: () => _buildInfoCard(
                context,
                title: 'الصلاة القادمة',
                content: '...',
                icon: Icons.access_time,
              ),
              error: (e, s) => _buildInfoCard(
                context,
                title: 'الصلاة القادمة',
                content: 'خطأ',
                icon: Icons.error,
              ),
            ),
            const SizedBox(height: 16),

            // Last Read Card
            lastReadAsync.when(
              data: (page) => _buildInfoCard(
                context,
                title: 'آخر قراءة',
                content: 'صفحة $page',
                icon: Icons.menu_book,
                onTap: () => context.go('/quran/read/$page'),
              ),
              loading: () => _buildInfoCard(
                context,
                title: 'آخر قراءة',
                content: '...',
                icon: Icons.menu_book,
              ),
              error: (e, s) => _buildInfoCard(
                context,
                title: 'آخر قراءة',
                content: 'بداية المصحف',
                icon: Icons.menu_book,
                onTap: () => context.go('/quran'),
              ),
            ),
            const SizedBox(height: 16),

            // Daily Dhikr Card
            dailyDhikrAsync.when(
              data: (item) => _buildInfoCard(
                context,
                title: 'ذكر اليوم',
                content: item?.text ?? 'سبحان الله',
                icon: Icons.favorite,
              ),
              loading: () => _buildInfoCard(
                context,
                title: 'ذكر اليوم',
                content: '...',
                icon: Icons.favorite,
              ),
              error: (e, s) => _buildInfoCard(
                context,
                title: 'ذكر اليوم',
                content: 'الحمد لله',
                icon: Icons.favorite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 32, color: Theme.of(context).primaryColor),
              const SizedBox(height: 8),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Internal Providers for Home Screen logic

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
  // Simple logic: Get morning adhkar and pick random
  final morning = await repo.getMorningAdhkar();
  if (morning.isNotEmpty) {
    return morning[Random().nextInt(morning.length)];
  }
  return null;
});
