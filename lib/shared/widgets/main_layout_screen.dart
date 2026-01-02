import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class MainLayoutScreen extends StatelessWidget {
  final Widget child;
  const MainLayoutScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _BottomNavBar(),
      extendBody:
          false, // Design shows white bg, not floating over content usually, but checked 'fixed bottom' in CSS.
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.95),
        border: const Border(top: BorderSide(color: Color(0xFFE5E7EB))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 70, // Height from CSS/Visual
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1. Home (Rightmost in RTL)
              _NavItem(
                icon: Icons.home_outlined,
                // filled: Icons.home
                label: 'الرئيسية',
                isSelected: currentPath == '/',
                onTap: () => context.go('/'),
              ),
              // 2. Quran
              _NavItem(
                icon: Icons.menu_book_outlined,
                label: 'القرآن',
                isSelected: currentPath == '/quran',
                onTap: () => context.go('/quran'),
              ),
              // 3. Awrad
              _NavItem(
                icon: Icons.auto_awesome_outlined,
                label: 'الأوراد',
                isSelected: currentPath == '/awrad',
                onTap: () => context.go('/awrad'),
              ),
              // 4. Azkar
              _NavItem(
                icon: Icons.self_improvement_outlined,
                label: 'الأذكار',
                isSelected: currentPath == '/azkar',
                onTap: () => context.go('/azkar'),
              ),
              // 5. Assistant
              _NavItem(
                icon: Icons.assistant_outlined,
                label: 'المساعد',
                isSelected: currentPath == '/assistant',
                onTap: () => context.go('/assistant'),
              ),
              // 6. Settings (Leftmost in RTL)
              _NavItem(
                icon: Icons.settings_outlined,
                label: 'الإعدادات',
                isSelected: currentPath == '/settings',
                onTap: () => context.go('/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Styling from CSS:
    // text-gray-400 hover:text-primary dark:hover:text-accent
    // Active: text-primary (or accent in dark mode)
    // CSS also used a pill background for Active Home: bg-primary/10 px-4 py-1 rounded-full

    // Simplification for Flutter:
    // Selected: Primary Color + Bold
    // Unselected: Grey

    final color = isSelected ? AppColors.primary : Colors.grey.shade400;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: isSelected && label == 'الرئيسية'
            ? BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: color,
                fontFamily: 'Cairo', // Explicitly Cairo
              ),
            ),
          ],
        ),
      ),
    );
  }
}
