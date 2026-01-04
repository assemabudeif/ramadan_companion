import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
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
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
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
      backgroundColor: const Color(0xFFF9F7F2), // Creamy Mushaf background
      body: Stack(
        children: [
          // The PageView
          PageView.builder(
            controller: _pageController,
            reverse: true,
            itemCount: 604,
            onPageChanged: (index) {
              final page = index + 1;
              setState(() => _currentPage = page);
              ref.read(quranRepositoryProvider).saveLastRead(page);
            },
            itemBuilder: (context, index) {
              final pageNum = index + 1;
              return QuranPageWidget(pageNumber: pageNum);
            },
          ),

          // Top Info Bar (Floating)
          Positioned(top: 0, left: 0, right: 0, child: _buildTopBar(context)),

          // Bottom Control Bar
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildControlBar(context),
          ),

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppColors.primary, size: 28),
              onPressed: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    // Determine Surah and Juz for the current page
    String surahName = 'سورة البقرة';
    // Logic to determine surah name could go here

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F7F2).withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: AppColors.accent.withOpacity(0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInfoItem(surahName, Icons.menu_book), // Dynamic lookup later
          const SizedBox(width: 24),
          _buildInfoItem('الجزء الأول', Icons.bookmark),
          const SizedBox(width: 24),
          _buildInfoItem('صفحة $_currentPage', Icons.description),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: AppColors.accent),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildControlBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildControlButton(Icons.menu_open, 'تفسير', () {}),
          _buildControlButton(Icons.share_outlined, 'مشاركة', () {}),
          _buildControlButton(Icons.text_format, 'الخط', () {}),
          _buildControlButton(Icons.bookmark_border, 'حفظ', () {}),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.accent, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class QuranPageWidget extends ConsumerWidget {
  final int pageNumber;

  const QuranPageWidget({super.key, required this.pageNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versesAsync = ref.watch(quranPageProvider(pageNumber));

    return versesAsync.when(
      data: (verses) {
        if (verses.isEmpty) {
          return const Center(child: Text('صفحة فارغة'));
        }
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/mushaf_page_border.png'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                AppColors.primary.withOpacity(0.05),
                BlendMode.dstIn,
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(40, 100, 40, 100),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text.rich(
                      TextSpan(
                        children: verses
                            .map((v) => _buildVerseSpan(context, ref, v))
                            .toList(),
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    ),
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

  InlineSpan _buildVerseSpan(
    BuildContext context,
    WidgetRef ref,
    QuranAyah ayah,
  ) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: InkWell(
        onTap: () => _showTafseer(context, ref, ayah),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${ayah.text} ',
                style: const TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 24,
                  height: 2.0,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.accent, width: 1.5),
                  ),
                  child: Text(
                    '${ayah.numberInSurah}',
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),
              const TextSpan(text: ' '),
            ],
          ),
          textDirection: TextDirection.rtl,
        ),
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
