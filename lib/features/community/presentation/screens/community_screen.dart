import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'المجتمع الرمضاني',
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
            // Global Collective Goal
            _buildCollectiveGoal(context),
            const SizedBox(height: 24),

            _buildSectionHeader('تفاعلات المجتمع'),
            const SizedBox(height: 16),

            _buildPostCard(
              'أحمد محمد',
              'الحمد لله ختمت الجزء العاشر اليوم، شعور رائع بالانجاز والسكينة. بارك الله فيكم جميعاً.',
              'منذ ١٠ دقائق',
              '١٢٢ إعجاب',
            ),
            const SizedBox(height: 16),
            _buildPostCard(
              'فاطمة علي',
              'صلوا على النبي محمد صلى الله عليه وسلم، اليوم ذكر الجماعة هو الصلاة على النبي.',
              'منذ ٣٠ دقيقة',
              '٥٠٠ إعجاب',
            ),

            const SizedBox(height: 24),
            _buildSectionHeader('مسابقات رمضانية'),
            const SizedBox(height: 16),
            _buildChallengeCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_comment_outlined, color: Colors.white),
      ),
    );
  }

  Widget _buildCollectiveGoal(BuildContext context) {
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
            'الصلاة على النبي اليوم',
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'هدفنا الجماعي اليومي',
            style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Text(
            '١,٢٤٠,٥٠٠',
            style: GoogleFonts.manrope(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'صلاة تمت حتى الآن',
            style: GoogleFonts.cairo(fontSize: 13, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: 0.8,
            backgroundColor: Colors.grey[100],
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildPostCard(String name, String text, String time, String likes) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  name[0],
                  style: const TextStyle(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: GoogleFonts.cairo(fontSize: 14, height: 1.6),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.favorite_rounded, color: Colors.red, size: 18),
              const SizedBox(width: 6),
              Text(
                likes,
                style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),
              const Icon(
                Icons.chat_bubble_outline,
                color: Colors.grey,
                size: 18,
              ),
              const SizedBox(width: 6),
              const Icon(Icons.share_outlined, color: Colors.grey, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.accent, Color(0xFFC49A3D)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_events_outlined,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تحدي حفظ سورة الملك',
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'انضم لـ ١,٥٠٠ متسابق الآن',
                  style: GoogleFonts.cairo(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'انضمام',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
