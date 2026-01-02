import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/core/router/app_router.dart';
import 'package:ramadan_companion/core/services/sync_service.dart';

void main() {
  runApp(const ProviderScope(child: RamadanCompanionApp()));
}

class RamadanCompanionApp extends ConsumerWidget {
  const RamadanCompanionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    // Trigger initialization
    ref.listen(syncServiceProvider, (_, __) {}); // Keep alive
    ref.read(syncServiceProvider).seedInitialData();

    return MaterialApp.router(
      title: 'Ramadan Companion',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar')],
      routerConfig: router,
    );
  }
}
