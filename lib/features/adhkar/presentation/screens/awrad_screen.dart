import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/features/quran/data/repositories/quran_repository.dart';

class AwradScreen extends ConsumerWidget {
  const AwradScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, these values would come from a progress service/provider
    const double progress = 0.65;
    const int pagesRead = 13;
    const int targetPages = 20;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الأوراد والختمة',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Today's Progress Section
            _buildProgressSection(context, progress, pagesRead, targetPages),
            const SizedBox(height: 24),

            // Resume Reading Card
            _buildResumeCard(context, ref),
            const SizedBox(height: 24),

            // Weekly Tracking
            _buildWeeklyTracker(context),
            const SizedBox(height: 24),

            // Quick Actions / Stats
            _buildStatsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(
    BuildContext context,
    double progress,
    int pages,
    int target,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'ورد اليوم',
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey[100],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accent,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'تموزج',
                    style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'متبقي ٧ صفحات لإنهاء ورد اليوم',
            style: GoogleFonts.cairo(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeCard(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        final lastPage = await ref
            .read(quranRepositoryProvider)
            .getLastReadPage();
        if (context.mounted) context.push('/quran/read/$lastPage');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, Color(0xFF046D39)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.menu_book, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'متابعة القراءة',
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'سورة البقرة • صفحة ٢٤',
                    style: GoogleFonts.cairo(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyTracker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تتبع الأسبوع',
          style: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['س', 'ج', 'خ', 'أ', 'ث', 'إ', 'ح'].map((day) {
            bool isCompleted = day == 'ح' || day == 'إ'; // Placeholder
            return Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted ? AppColors.accent : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 6),
                Text(
                  day,
                  style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem('إجمالي الصفحات', '٣٤٢', Icons.pages_outlined),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatItem(
            'أيام الالتزام',
            '١٢ يوم',
            Icons.calendar_today_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent, size: 20),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.cairo(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
