import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/core/theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final isDark = themeAsync.valueOrNull == ThemeMode.dark;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الإعدادات',
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
            // User Profile Preview (Placeholder)
            _buildProfileCard(),
            const SizedBox(height: 24),

            _buildSectionHeader('المظهر والتنبيهات'),
            _buildSettingsGroup([
              _buildSwitchTile(
                'الوضع الليلي',
                'تفعيل المظهر الداكن للتطبيق',
                Icons.dark_mode_outlined,
                isDark,
                (val) =>
                    ref.read(themeNotifierProvider.notifier).toggleTheme(val),
              ),
              _buildNavigationTile(
                'إشعاراتي',
                'تخصيص تنبيهات الصلاة والأذكار',
                Icons.notifications_active_outlined,
                () => context.push('/settings/notifications'),
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader('اللغة والمكان'),
            _buildSettingsGroup([
              _buildValueTile(
                'لغة التطبيق',
                'العربية',
                Icons.language_outlined,
              ),
              _buildValueTile(
                'الموقع الحالي',
                'الكويت، مدينة الكويت',
                Icons.location_on_outlined,
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader('المزيد'),
            _buildSettingsGroup([
              _buildNavigationTile(
                'قيم التطبيق',
                'شاركنا رأيك لتحسين التطبيق',
                Icons.star_outline_rounded,
                () {},
              ),
              _buildNavigationTile(
                'تواصل معنا',
                'للمقترحات والشكاوى',
                Icons.mail_outline,
                () {},
              ),
              _buildValueTile('الإصدار', '1.2.0', Icons.info_outline),
            ]),

            const SizedBox(height: 40),
            Text(
              'صنع بكل حب ليرافقك في رمضان',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(
              Icons.person_outline,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ضيف الرحمن',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'رمضان مبارك عليك',
                  style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: Colors.grey, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primary.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.cairo(fontSize: 11, color: Colors.grey),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildNavigationTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.cairo(fontSize: 11, color: Colors.grey),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildValueTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        value,
        style: GoogleFonts.cairo(
          fontSize: 13,
          color: AppColors.accent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
