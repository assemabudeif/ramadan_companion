import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ramadan_companion/core/theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final isDark = themeAsync.valueOrNull == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), centerTitle: true),
      body: ListView(
        children: [
          const _SectionHeader(title: 'المظهر'),
          SwitchListTile(
            title: const Text('الوضع الليلي'),
            subtitle: const Text('تبديل بين الوضع الفاتح والداكن'),
            value: isDark,
            onChanged: (val) {
              ref.read(themeNotifierProvider.notifier).toggleTheme(val);
            },
            secondary: const Icon(Icons.brightness_4),
          ),

          const Divider(),
          const _SectionHeader(title: 'التنبيهات'),
          SwitchListTile(
            title: const Text('تذكير يومي'),
            subtitle: const Text('تذكيرات بقراءة الأذكار'),
            value: true, // TODO: Connect to Notification Preferences
            onChanged: (val) {
              // TODO: Implement Notification Toggle
            },
            secondary: const Icon(Icons.notifications_active),
          ),

          const Divider(),
          const _SectionHeader(title: 'عن التطبيق'),
          ListTile(
            title: const Text('الإصدار'),
            subtitle: const Text('1.0.0'),
            leading: const Icon(Icons.info_outline),
          ),
          ListTile(
            title: const Text('قيم التطبيق'),
            leading: const Icon(Icons.star_rate_rounded),
            onTap: () {
              // Open Store
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
