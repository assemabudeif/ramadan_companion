import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الإشعارات',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'مسح الكل',
              style: GoogleFonts.cairo(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip('الكل', true),
                _buildFilterChip('تذكيرات الصلاة', false),
                _buildFilterChip('تنبيهات السحور', false),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildNotificationItem(
                  icon: Icons.mosque,
                  title: 'حان الآن موعد صلاة العصر',
                  subtitle:
                      'حان الآن موعد صلاة العصر حسب التوقيت المحلي لمدينة الرياض',
                  time: 'منذ ٢٠ دقيقة',
                  isUnread: true,
                ),
                _buildNotificationItem(
                  icon: Icons.wb_sunny,
                  title: 'اقترب موعد الإفطار',
                  subtitle:
                      'تقبل الله صيامكم وقيامكم، لا تنس الدعاء عند الإفطار',
                  time: 'منذ ٤٥ دقيقة',
                  isUnread: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'الأمس',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
                _buildNotificationItem(
                  icon: Icons.menu_book,
                  title: 'أذكار المساء',
                  subtitle: 'حان وقت قراءة أذكار المساء لتحصين نفسك',
                  time: 'أمس، ٥:٣٠ م',
                  isUnread: false,
                ),
                _buildNotificationItem(
                  icon: Icons.tips_and_updates,
                  title: 'تحديث جديد للتطبيق',
                  subtitle:
                      'تم إضافة ميزة ختمة القرآن الكريم وإمساكية شهر رمضان',
                  time: 'أمس، ١٠:٠٠ ص',
                  isUnread: false,
                ),
                _buildNotificationItem(
                  icon: Icons.nights_stay,
                  title: 'تنبيه السحور',
                  subtitle: 'باقي ساعة واحدة على موعد أذان الفجر',
                  time: 'أمس، ٣:٤٥ ص',
                  isUnread: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey[200]!,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.cairo(
          color: isSelected ? Colors.white : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isUnread
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: GoogleFonts.cairo(
                    fontSize: 11,
                    color: Colors.grey[400],
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
