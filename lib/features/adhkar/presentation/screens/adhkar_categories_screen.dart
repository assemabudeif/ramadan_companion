import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:ramadan_companion/features/adhkar/data/repositories/adhkar_repository.dart';

part 'adhkar_categories_screen.g.dart';

class AdhkarCategoriesScreen extends ConsumerWidget {
  const AdhkarCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(adhkarCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('الأذكار'), centerTitle: true),
      body: categoriesAsync.when(
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text('لا توجد أذكار متاحة'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return _CategoryCard(category: category);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final DhikrCategory category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.push('/azkar/${category.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                Icons.spa,
                color: Theme.of(context).primaryColor,
              ), // Flower icon used for Adhkar often
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@riverpod
Future<List<DhikrCategory>> adhkarCategories(AdhkarCategoriesRef ref) {
  return ref.watch(adhkarRepositoryProvider).getCategories();
}
