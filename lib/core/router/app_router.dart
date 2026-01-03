import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:ramadan_companion/shared/widgets/main_layout_screen.dart';
import 'package:ramadan_companion/features/placeholders.dart'
    hide HomeScreen, QuranScreen, AzkarScreen;
import 'package:ramadan_companion/features/home/presentation/screens/home_screen.dart';
import 'package:ramadan_companion/features/quran/presentation/screens/quran_index_screen.dart';
import 'package:ramadan_companion/features/quran/presentation/screens/quran_page_view_screen.dart';

import 'package:ramadan_companion/features/adhkar/presentation/screens/adhkar_categories_screen.dart';
import 'package:ramadan_companion/features/adhkar/presentation/screens/adhkar_details_screen.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
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
            routes: [
              GoRoute(
                path: 'read/:page',
                parentNavigatorKey: _rootNavigatorKey, // Hide bottom nav
                builder: (context, state) {
                  final page = int.parse(state.pathParameters['page'] ?? '1');
                  return QuranPageViewScreen(initialPage: page);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/awrad',
            builder: (context, state) => const AwradScreen(),
          ),
          GoRoute(
            path: '/azkar',
            builder: (context, state) => const AdhkarCategoriesScreen(),
            routes: [
              GoRoute(
                path: ':categoryId',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final categoryId = int.parse(
                    state.pathParameters['categoryId'] ?? '1',
                  );
                  // Pass categoryId to the screen.
                  // We might want to pass Title too, but we can fetch it or just show generic title.
                  return AdhkarDetailsScreen(categoryId: categoryId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/assistant',
            builder: (context, state) => const AssistantScreen(),
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
