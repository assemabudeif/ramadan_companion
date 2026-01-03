import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:ramadan_companion/features/adhkar/data/repositories/adhkar_repository.dart';

part 'awrad_screen.g.dart';

class AwradScreen extends ConsumerWidget {
  const AwradScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteAdhkarProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('أورادي'), centerTitle: true),
      body: favoritesAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'لا توجد أوراد مفضلة بعد',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'أضف الأذكار المفضلة للوصول السريع إليها',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return _FavoriteItemCard(item: item);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _FavoriteItemCard extends ConsumerWidget {
  final DhikrItem item;

  const _FavoriteItemCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () async {
                    final repo = ref.read(adhkarRepositoryProvider);
                    await repo.toggleFavorite(item.id);
                    ref.invalidate(favoriteAdhkarProvider); // Refresh list
                  },
                ),
                Text(
                  item.category.value?.name ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
            Text(
              item.text,
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 18,
                height: 1.6,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

@riverpod
Future<List<DhikrItem>> favoriteAdhkar(FavoriteAdhkarRef ref) {
  return ref.watch(adhkarRepositoryProvider).getFavoriteAdhkar();
}
