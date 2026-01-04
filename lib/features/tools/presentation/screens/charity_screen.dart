import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class CharityScreen extends StatelessWidget {
  const CharityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'صدقات وجاري',
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
            // Filter Chip Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('الكل', true),
                  _buildFilterChip('كفالة أيتام', false),
                  _buildFilterChip('سقيا ماء', false),
                  _buildFilterChip('بناء مساجد', false),
                  _buildFilterChip('إطعام مسكين', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('مشاريع عاجلة'),
            const SizedBox(height: 16),
            _buildCharityCard(
              'كسوة الشتاء للأسر المتعففة',
              'مبادرة لتوفير الملابس الشتوية والبطانيات للعائلات في المناطق الباردة.',
              0.75,
              '٧,٥٠٠',
              '١٠,٠٠٠',
              'assets/images/charity_winter.jpg',
            ),
            const SizedBox(height: 16),
            _buildCharityCard(
              'حفر بئر ارتوازي في أفريقيا',
              'توفير مياه نظيفة وصالحة للشرب لقرية تعاني من الجفاف الشديد.',
              0.42,
              '٢,١٠٠',
              '٥,٠٠٠',
              'assets/images/charity_water.jpg',
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('صدقة جارية'),
            const SizedBox(height: 16),
            _buildCharityCard(
              'بناء مركز تحفيظ قرآن',
              'المساهمة في بناء صرح تعليمي لخدمة أبناء المسلمين وتنشئتهم على القرآن.',
              0.15,
              '٣,٠٠٠',
              '٢٠,٠٠٠',
              'assets/images/charity_mosque.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: Colors.grey[200]!),
      ),
      child: Text(
        label,
        style: GoogleFonts.cairo(
          color: isSelected ? Colors.white : Colors.grey[600],
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'عرض الكل',
            style: GoogleFonts.cairo(color: AppColors.accent, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildCharityCard(
    String title,
    String desc,
    double progress,
    String current,
    String target,
    String img,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image / Header
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
                onError: (_, __) {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تم جمع $current ${"د.ك"}',
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                    Text(
                      'الهدف $target ${"د.ك"}',
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[100],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accent,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'تبرع الآن',
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                    ),
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
