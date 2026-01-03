import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:ramadan_companion/features/adhkar/data/repositories/adhkar_repository.dart';

part 'adhkar_details_screen.g.dart';

class AdhkarDetailsScreen extends ConsumerWidget {
  final int categoryId;

  const AdhkarDetailsScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(categoryAdhkarProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأذكار'), // Could fetch category name dynamically
        centerTitle: true,
      ),
      body: itemsAsync.when(
        data: (items) {
          if (items.isEmpty) return const Center(child: Text('لا توجد عناصر'));
          return PageView.builder(
            // Use PageView for focused Dhikr experience or ListView?
            // Common practice: ListView for scroll, Tap to count.
            // Let's stick to ListView for now to see all, but PageView is better for focus.
            // Let's try ListView first as it's standard for long lists (Morning/Evening).
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _DhikrCard(item: items[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _DhikrCard extends StatefulWidget {
  final DhikrItem item;

  const _DhikrCard({required this.item});

  @override
  State<_DhikrCard> createState() => _DhikrCardState();
}

class _DhikrCardState extends State<_DhikrCard> {
  late int currentCount;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    currentCount = widget.item.targetCount;
    isCompleted = currentCount == 0;
  }

  void _decrement() {
    if (currentCount > 0) {
      setState(() {
        currentCount--;
      });
      HapticFeedback.lightImpact();

      if (currentCount == 0) {
        setState(() {
          isCompleted = true;
        });
        HapticFeedback.mediumImpact();
      }
    }
  }

  void _reset() {
    setState(() {
      currentCount = widget.item.targetCount;
      isCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.withOpacity(0.1) : theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isCompleted
            ? Border.all(color: Colors.green, width: 2)
            : Border.all(color: Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _decrement,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text
                Text(
                  widget.item.text,
                  style: const TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 20,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),

                const SizedBox(height: 16),

                if (widget.item.description != null &&
                    widget.item.description!.isNotEmpty) ...[
                  Text(
                    widget.item.description!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 16),
                ],

                // Footer (Count)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.grey),
                      onPressed: _reset,
                    ),

                    // Counter Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted ? Colors.green : theme.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        isCompleted
                            ? 'تم'
                            : '$currentCount / ${widget.item.targetCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    Consumer(
                      builder: (context, ref, child) {
                        return IconButton(
                          icon: Icon(
                            widget.item.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.item.isFavorite
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () async {
                            final repo = ref.read(adhkarRepositoryProvider);
                            await repo.toggleFavorite(widget.item.id);

                            // Re-fetch parent list/items?
                            // With FutureProvider, if we invalidate, it reloads all items and resets state (counts).
                            // Ideally, we handle state locally or use StreamProvider.
                            // For MVP simplicity: just setState to reflect UI locally, but DB is updated.
                            // If we reload, we lose count.
                            // Let's just update local UI state for now.
                            setState(() {
                              widget.item.isFavorite = !widget.item.isFavorite;
                            });
                          },
                        );
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.grey),
                      onPressed: () {}, // Share placeholder
                    ),
                  ],
                ),

                if (isCompleted)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'أحسنت!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@riverpod
Future<List<DhikrItem>> categoryAdhkar(CategoryAdhkarRef ref, int categoryId) {
  return ref.watch(adhkarRepositoryProvider).getAdhkarByCategory(categoryId);
}
