import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/features/quran/data/repositories/quran_repository.dart';
import 'package:ramadan_companion/features/quran/data/models/quran_model.dart';

class QuranIndexScreen extends ConsumerStatefulWidget {
  const QuranIndexScreen({super.key});

  @override
  ConsumerState<QuranIndexScreen> createState() => _QuranIndexScreenState();
}

class _QuranIndexScreenState extends ConsumerState<QuranIndexScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<QuranSurah> _allSurahs = [];
  List<QuranSurah> _filteredSurahs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadSurahs();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadSurahs() async {
    final repo = ref.read(quranRepositoryProvider);
    final surahs = await repo.getAllSurahs();
    if (mounted) {
      setState(() {
        _allSurahs = surahs;
        _filteredSurahs = surahs;
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSurahs = _allSurahs.where((s) {
        return s.nameAr.contains(query) ||
            s.nameEn.toLowerCase().contains(query) ||
            s.number.toString().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'القرآن الكريم',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.accent,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          labelStyle: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: 'السور'),
            Tab(text: 'الأجزاء'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'ابحث عن سورة أو آية...',
                hintStyle: GoogleFonts.cairo(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildSurahList(), _buildJuzList()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahList() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_filteredSurahs.isEmpty) {
      return Center(
        child: Text(
          'لا توجد نتائج',
          style: GoogleFonts.cairo(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredSurahs.length,
      itemBuilder: (context, index) {
        final surah = _filteredSurahs[index];
        return _buildSurahTile(surah);
      },
    );
  }

  Widget _buildSurahTile(QuranSurah surah) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.star, color: AppColors.accent, size: 40),
            Text(
              '${surah.number}',
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        title: Text(
          surah.nameAr,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              surah.type == 'Makkiyah' ? 'مكية' : 'مدنية',
              style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${surah.totalVerses} آية',
              style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: Text(
          surah.nameEn,
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: AppColors.accent,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () => _navigateToSurah(surah),
      ),
    );
  }

  Widget _buildJuzList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 30,
      itemBuilder: (context, index) {
        final juzNumber = index + 1;
        return _buildJuzTile(juzNumber);
      },
    );
  }

  Widget _buildJuzTile(int juzNumber) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$juzNumber',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        title: Text(
          'الجزء $juzNumber',
          style: GoogleFonts.cairo(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () => _navigateToJuz(juzNumber),
      ),
    );
  }

  Future<void> _navigateToSurah(QuranSurah surah) async {
    final repo = ref.read(quranRepositoryProvider);
    final ayahs = await repo.getAyahsBySurah(surah.number);
    if (ayahs.isNotEmpty) {
      final startPage = ayahs.first.pageNumber;
      if (mounted) context.push('/quran/read/$startPage');
    }
  }

  void _navigateToJuz(int juzNumber) {
    // Standard Mushaf Juz start pages
    final juzStartPages = [
      1,
      22,
      42,
      62,
      82,
      102,
      122,
      142,
      162,
      182,
      202,
      222,
      242,
      262,
      282,
      302,
      322,
      342,
      362,
      382,
      402,
      422,
      442,
      462,
      482,
      502,
      522,
      542,
      562,
      582,
    ];
    final startPage = juzStartPages[juzNumber - 1];
    context.push('/quran/read/$startPage');
  }
}
