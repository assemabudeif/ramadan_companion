import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:ramadan_companion/shared/widgets/main_layout_screen.dart';
import 'package:ramadan_companion/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:ramadan_companion/features/home/presentation/screens/home_screen.dart';
import 'package:ramadan_companion/features/quran/presentation/screens/quran_index_screen.dart';
import 'package:ramadan_companion/features/quran/presentation/screens/quran_page_view_screen.dart';

import 'package:ramadan_companion/features/adhkar/presentation/screens/adhkar_categories_screen.dart';
import 'package:ramadan_companion/features/adhkar/presentation/screens/adhkar_details_screen.dart';
import 'package:ramadan_companion/features/adhkar/presentation/screens/awrad_screen.dart';
import 'package:ramadan_companion/features/adhkar/presentation/screens/dua_library_screen.dart';
import 'package:ramadan_companion/features/tools/presentation/screens/qibla_screen.dart';
import 'package:ramadan_companion/features/tools/presentation/screens/charity_screen.dart';
import 'package:ramadan_companion/features/tools/presentation/screens/zakat_calculator_screen.dart';
import 'package:ramadan_companion/features/assistant/presentation/screens/assistant_screen.dart';
import 'package:ramadan_companion/features/community/presentation/screens/community_screen.dart';
import 'package:ramadan_companion/features/settings/presentation/screens/settings_screen.dart';
import 'package:ramadan_companion/features/settings/presentation/screens/notifications_screen.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/welcome',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      // Full-screen routes (hiding bottom nav)
      GoRoute(
        path: '/quran/read/:page',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final page = int.parse(state.pathParameters['page'] ?? '1');
          return QuranPageViewScreen(initialPage: page);
        },
      ),
      GoRoute(
        path: '/azkar/:categoryId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final categoryId = int.parse(
            state.pathParameters['categoryId'] ?? '1',
          );
          return AdhkarDetailsScreen(categoryId: categoryId);
        },
      ),
      GoRoute(
        path: '/qibla',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const QiblaScreen(),
      ),
      GoRoute(
        path: '/charity',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CharityScreen(),
      ),
      GoRoute(
        path: '/zakat',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ZakatCalculatorScreen(),
      ),
      GoRoute(
        path: '/dua-library',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const DuaLibraryScreen(),
      ),
      GoRoute(
        path: '/settings/notifications',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NotificationsScreen(),
      ),

      // Main Shell with Bottom Nav
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainLayoutScreen(child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/quran',
            builder: (context, state) => const QuranIndexScreen(),
          ),
          GoRoute(
            path: '/awrad',
            builder: (context, state) => const AwradScreen(),
          ),
          GoRoute(
            path: '/azkar',
            builder: (context, state) => const AdhkarCategoriesScreen(),
          ),
          GoRoute(
            path: '/assistant',
            builder: (context, state) => const AssistantScreen(),
          ),
          GoRoute(
            path: '/community',
            builder: (context, state) => const CommunityScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
