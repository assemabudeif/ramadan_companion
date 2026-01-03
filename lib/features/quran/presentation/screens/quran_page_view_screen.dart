import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/features/quran/data/repositories/quran_repository.dart';
import 'package:ramadan_companion/features/quran/data/models/quran_model.dart';

part 'quran_page_view_screen.g.dart';

class QuranPageViewScreen extends ConsumerStatefulWidget {
  final int initialPage;

  const QuranPageViewScreen({super.key, required this.initialPage});

  @override
  ConsumerState<QuranPageViewScreen> createState() =>
      _QuranPageViewScreenState();
}

class _QuranPageViewScreenState extends ConsumerState<QuranPageViewScreen> {
  late PageController _pageController;
  // Cache pages? Riverpod AutoDispose provider family handles caching nicely.

  @override
  void initState() {
    super.initState();
    // Page is 1-based, PageController is 0-based index?
    // Let's assume PageView index 0 = Page 1.
    // initialPage is 1-based passed from router.
    _pageController = PageController(initialPage: widget.initialPage - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // TODO: Bookmark current page
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        reverse: true, // Arabic flows right-to-left
        itemCount: 604, // Standard Mushaf pages
        itemBuilder: (context, index) {
          final pageNum = index + 1;
          return QuranPageWidget(pageNumber: pageNum);
        },
      ),
    );
  }
}

class QuranPageWidget extends ConsumerWidget {
  final int pageNumber;

  const QuranPageWidget({super.key, required this.pageNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch verses for this page
    final versesAsync = ref.watch(quranPageProvider(pageNumber));

    return versesAsync.when(
      data: (verses) {
        if (verses.isEmpty) {
          return const Center(child: Text('صفحة فارغة'));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              // Header info could go here (Juz, Surah Name)
              Text(
                'صفحة $pageNumber',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    textDirection: TextDirection.rtl,
                    alignment: WrapAlignment.center,
                    children: verses
                        .map((v) => _buildVerseItem(context, ref, v))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildVerseItem(BuildContext context, WidgetRef ref, QuranAyah ayah) {
    return InkWell(
      onTap: () => _showTafseer(context, ref, ayah),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${ayah.text} ',
              style: const TextStyle(
                fontFamily: 'Amiri', // Ensure font is available or use default
                fontSize: 22,
                height: 1.8,
                color: Colors.black87,
              ),
            ),
            TextSpan(
              text: '(${ayah.numberInSurah}) ',
              style: const TextStyle(fontSize: 14, color: Colors.teal),
            ),
          ],
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.justify,
      ),
    );
  }

  void _showTafseer(BuildContext context, WidgetRef ref, QuranAyah ayah) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return TafseerSheet(
            surah: ayah.surahNumber,
            ayah: ayah.numberInSurah,
            scrollController: scrollController,
          );
        },
      ),
    );
  }
}

class TafseerSheet extends ConsumerWidget {
  final int surah;
  final int ayah;
  final ScrollController scrollController;

  const TafseerSheet({
    super.key,
    required this.surah,
    required this.ayah,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tafseerAsync = ref.watch(tafseerProvider(surah, ayah));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: tafseerAsync.when(
        data: (tafseer) {
          return ListView(
            controller: scrollController,
            children: [
              Text(
                'تفسير الميسر',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                tafseer?.text ?? 'لا يوجد تفسير متاح',
                style: const TextStyle(fontSize: 18, height: 1.5),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error loading tafseer: $e')),
      ),
    );
  }
}

// Providers
@riverpod
Future<List<QuranAyah>> quranPage(QuranPageRef ref, int pageNumber) {
  return ref.watch(quranRepositoryProvider).getAyahsByPage(pageNumber);
}

@riverpod
Future<QuranTafseer?> tafseer(TafseerRef ref, int surah, int ayah) {
  return ref.watch(quranRepositoryProvider).getTafseer(surah, ayah);
}
