import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رمضان'), // Localize later
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Widget
            _buildInfoCard(
              context,
              title: 'التاريخ الهجري',
              content: 'Thinking...',
              icon: Icons.calendar_today,
            ),
            const SizedBox(height: 16),

            // Prayer Times
            _buildInfoCard(
              context,
              title: 'الصلاة القادمة',
              content: 'جاري الحساب...',
              icon: Icons.access_time,
            ),
            const SizedBox(height: 16),

            // Last Read
            _buildInfoCard(
              context,
              title: 'آخر قراءة',
              content: 'سورة الفاتحة - آية 1',
              icon: Icons.menu_book,
              onTap: () => context.go('/quran'), // Temporary link
            ),
            const SizedBox(height: 16),

            // Daily Athkar
            _buildInfoCard(
              context,
              title: 'ذكر اليوم',
              content: 'سبحان الله وبحمده',
              icon: Icons.favorite,
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
              const SizedBox(height: 4),
              Text(content, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
