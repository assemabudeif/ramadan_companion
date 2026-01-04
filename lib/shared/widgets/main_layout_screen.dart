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
              _NavItem(
                icon: Icons.home_outlined,
                label: 'الرئيسية',
                isSelected: currentPath == '/',
                onTap: () => context.go('/'),
              ),
              _NavItem(
                icon: Icons.menu_book_outlined,
                label: 'القرآن',
                isSelected: currentPath == '/quran',
                onTap: () => context.go('/quran'),
              ),
              _NavItem(
                icon: Icons.auto_awesome_outlined,
                label: 'الأوراد',
                isSelected: currentPath == '/awrad',
                onTap: () => context.go('/awrad'),
              ),
              _NavItem(
                icon: Icons
                    .favorite_border_rounded, // Changed to match "Athkar" feel
                label: 'الأذكار',
                isSelected: currentPath == '/azkar',
                onTap: () => context.go('/azkar'),
              ),
              _NavItem(
                icon: Icons.smart_toy_outlined, // "AI Assistant" bot icon
                label: 'المساعد',
                isSelected: currentPath == '/assistant',
                onTap: () => context.go('/assistant'),
              ),
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
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? _getFilledIcon(icon) : icon,
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: color,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFilledIcon(IconData icon) {
    if (icon == Icons.home_outlined) return Icons.home;
    if (icon == Icons.menu_book_outlined) return Icons.menu_book;
    if (icon == Icons.auto_awesome_outlined) return Icons.auto_awesome;
    if (icon == Icons.favorite_border_rounded) return Icons.favorite_rounded;
    if (icon == Icons.smart_toy_outlined) return Icons.smart_toy;
    if (icon == Icons.settings_outlined) return Icons.settings;
    return icon;
  }
}
