import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan_companion/features/quran/data/repositories/quran_repository.dart';
import 'package:ramadan_companion/features/quran/data/models/quran_model.dart';

class QuranIndexScreen extends ConsumerStatefulWidget {
  const QuranIndexScreen({super.key});

  @override
  ConsumerState<QuranIndexScreen> createState() => _QuranIndexScreenState();
}

class _QuranIndexScreenState extends ConsumerState<QuranIndexScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<QuranSurah> _allSurahs = [];
  List<QuranSurah> _filteredSurahs = [];

  @override
  void initState() {
    super.initState();
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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('فهرس السور'), centerTitle: true),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن سورة...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),

          // Surah List
          Expanded(
            child: _filteredSurahs.isEmpty
                ? const Center(child: Text('جاري التحميل...'))
                : ListView.separated(
                    itemCount: _filteredSurahs.length,
                    separatorBuilder: (c, i) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final surah = _filteredSurahs[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.1),
                          child: Text(
                            '${surah.number}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          surah.nameAr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${surah.nameEn} • ${surah.totalVerses} آية • ${surah.type}',
                        ),
                        onTap: () {
                          // Navigate to Page View starting at page 1 of this Surah?
                          // Or specific page mapping?
                          // Ideally, we find the starting page of the Surah.
                          // For now, simplicity: pass surah ID or look up page.
                          // We need startPage for the Surah.
                          // Repository could provide this, or we rely on page mapping.
                          // Let's assume user starts reading from Surah start.
                          // We need to look up the page number for Surah:1.

                          _navigateToSurah(surah);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToSurah(QuranSurah surah) async {
    // Determine start page.
    final repo = ref.read(quranRepositoryProvider);
    // Optimization: We could have stored startPage in QuranSurah model during seed.
    // For now, fetch first ayah.
    final ayahs = await repo.getAyahsBySurah(surah.number);
    if (ayahs.isNotEmpty) {
      final startPage = ayahs.first.pageNumber;
      if (mounted) {
        context.push('/quran/read/$startPage');
      }
    }
  }
}
