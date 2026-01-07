import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/features/adhkar/data/repositories/adhkar_repository.dart';
import 'package:ramadan_companion/features/quran/data/repositories/quran_repository.dart';
import 'package:ramadan_companion/features/quran/data/models/quran_model.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';

// Search Results State
class SearchResults {
  final List<QuranAyah> quranResults;
  final List<DhikrItem> adhkarResults;
  final List<Map<String, dynamic>> toolResults;

  SearchResults({
    this.quranResults = const [],
    this.adhkarResults = const [],
    this.toolResults = const [],
  });

  bool get isEmpty =>
      quranResults.isEmpty && adhkarResults.isEmpty && toolResults.isEmpty;
}

// Search Provider
final searchProvider = FutureProvider.family<SearchResults, String>((
  ref,
  query,
) async {
  if (query.trim().isEmpty) return SearchResults();

  final quranRepo = ref.read(quranRepositoryProvider);
  final adhkarRepo = ref.read(adhkarRepositoryProvider);

  // Parallel execution
  final results = await Future.wait([
    quranRepo.searchVerses(query),
    adhkarRepo.searchAdhkar(query),
  ]);

  final quranHits = results[0] as List<QuranAyah>;
  final adhkarHits = results[1] as List<DhikrItem>;

  // Static Tools Search
  final allTools = [
    {'name': 'القبلة', 'route': '/qibla', 'icon': Icons.compass_calibration},
    {'name': 'الزكاة', 'route': '/zakat', 'icon': Icons.calculate},
    {'name': 'التبرع', 'route': '/charity', 'icon': Icons.volunteer_activism},
    {'name': 'الإمساكية', 'route': '/imsakia', 'icon': Icons.calendar_month},
    {'name': 'المسبحة', 'route': '/tasbeeh', 'icon': Icons.fingerprint},
    {
      'name': 'أسماء الله الحسنى',
      'route': '/names-of-allah',
      'icon': Icons.stars,
    },
  ];

  final toolHits = allTools
      .where((t) => (t['name'] as String).contains(query))
      .toList();

  return SearchResults(
    quranResults: quranHits,
    adhkarResults: adhkarHits,
    toolResults: toolHits,
  );
});

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted && _query != query) {
        setState(() {
          _query = query;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = ref.watch(searchProvider(_query));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchHeader(),
            Expanded(
              child: _query.isEmpty
                  ? _buildRecentSearches()
                  : _buildSearchResults(searchAsync),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: TextFormField(
                controller: _searchController,
                autofocus: true,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'البحث عن آية، ذكر، أو أداة...',
                  hintStyle: GoogleFonts.cairo(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مقترحات البحث',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _searchTag('الكهف'),
              _searchTag('أذكار الصباح'),
              _searchTag('الزكاة'),
              _searchTag('استغفار'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _searchTag(String label) {
    return ActionChip(
      label: Text(label, style: GoogleFonts.cairo(fontSize: 12)),
      onPressed: () {
        _searchController.text = label;
        _onSearchChanged(label);
      },
      backgroundColor: Colors.white,
      labelStyle: const TextStyle(color: AppColors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey[200]!),
      ),
    );
  }

  Widget _buildSearchResults(AsyncValue<SearchResults> searchAsync) {
    return searchAsync.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Text(
              'لا توجد نتائج',
              style: GoogleFonts.cairo(color: Colors.grey),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            if (results.toolResults.isNotEmpty) ...[
              _buildSectionHeader('الأدوات'),
              ...results.toolResults.map((t) => _buildToolResult(t)),
            ],
            if (results.quranResults.isNotEmpty) ...[
              _buildSectionHeader(
                'القرآن الكريم (${results.quranResults.length})',
              ),
              ...results.quranResults.take(10).map((v) => _buildQuranResult(v)),
            ],
            if (results.adhkarResults.isNotEmpty) ...[
              _buildSectionHeader('الأذكار (${results.adhkarResults.length})'),
              ...results.adhkarResults
                  .take(10)
                  .map((d) => _buildAdhkarResult(d)),
            ],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('حدث خطأ: $err')),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildQuranResult(QuranAyah ayah) {
    return _ResultTile(
      title: 'سورة رقم ${ayah.surahNumber}', // Ideally map to name
      subtitle: ayah.text,
      icon: Icons.menu_book,
      onTap: () => context.push('/quran/read/${ayah.pageNumber}'),
    );
  }

  Widget _buildAdhkarResult(DhikrItem item) {
    return _ResultTile(
      title: 'ذكر',
      subtitle: item.text,
      icon: Icons.wb_sunny_outlined,
      onTap: () {
        // Ideally navigate to details, but we only have category view.
        // Just show a dialog or maybe navigate to category if we had ID.
        // For now, simple dialog to read it.
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              item.text,
              style: GoogleFonts.cairo(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildToolResult(Map<String, dynamic> tool) {
    return _ResultTile(
      title: tool['name'],
      subtitle: 'أداة مساعدة',
      icon: tool['icon'],
      onTap: () => context.push(tool['route']),
    );
  }
}

class _ResultTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ResultTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          title,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
