import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: RamadanCompanionApp()));
}

class RamadanCompanionApp extends StatelessWidget {
  const RamadanCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ramadan Companion',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.system,
    );
  }
}
