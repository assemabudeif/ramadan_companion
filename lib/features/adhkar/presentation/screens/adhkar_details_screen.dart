import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/features/adhkar/data/models/adhkar_model.dart';
import 'package:ramadan_companion/features/adhkar/data/repositories/adhkar_repository.dart';

part 'adhkar_details_screen.g.dart';

class AdhkarDetailsScreen extends ConsumerStatefulWidget {
  final int categoryId;

  const AdhkarDetailsScreen({super.key, required this.categoryId});

  @override
  ConsumerState<AdhkarDetailsScreen> createState() =>
      _AdhkarDetailsScreenState();
}

class _AdhkarDetailsScreenState extends ConsumerState<AdhkarDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(categoryAdhkarProvider(widget.categoryId));

    return itemsAsync.when(
      data: (items) {
        if (items.isEmpty) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('لا توجد أذكار في هذه الفئة')),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'الأذكار',
              style: GoogleFonts.cairo(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: LinearProgressIndicator(
                value: (items.isEmpty) ? 0 : (_currentIndex + 1) / items.length,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.accent,
                ),
              ),
            ),
          ),
          body: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _DhikrContentView(
                item: items[index],
                onNext: () {
                  if (index < items.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Show Completion
                    _showCompletionDialog(context);
                  }
                },
              );
            },
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'تم الانتهاء',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'تقبل الله طاعتكم وجزاكم الله خيراً',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'العودة للفئات',
              style: GoogleFonts.cairo(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _DhikrContentView extends StatefulWidget {
  final DhikrItem item;
  final VoidCallback onNext;

  const _DhikrContentView({required this.item, required this.onNext});

  @override
  State<_DhikrContentView> createState() => _DhikrContentViewState();
}

class _DhikrContentViewState extends State<_DhikrContentView> {
  late int currentCount;

  @override
  void initState() {
    super.initState();
    currentCount = widget.item.targetCount;
  }

  void _onPress() {
    if (currentCount > 0) {
      setState(() {
        currentCount--;
      });
      HapticFeedback.lightImpact();
      if (currentCount == 0) {
        HapticFeedback.mediumImpact();
        Future.delayed(const Duration(milliseconds: 500), widget.onNext);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // The Dhikr Text
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  widget.item.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 26,
                    height: 1.8,
                    color: Color(0xFF2D2D2D),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),

          if (widget.item.virtue != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                widget.item.virtue!,
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),

          const SizedBox(height: 40),

          // Large Counter Circle
          GestureDetector(
            onTap: _onPress,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: widget.item.targetCount == 0
                        ? 1
                        : (widget.item.targetCount - currentCount) /
                              widget.item.targetCount,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.accent,
                    ),
                  ),
                ),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$currentCount',
                        style: GoogleFonts.manrope(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'متبقي',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallIconButton(
                Icons.refresh,
                () => setState(() => currentCount = widget.item.targetCount),
              ),
              const SizedBox(width: 24),
              _buildSmallIconButton(Icons.share_outlined, () {}),
              const SizedBox(width: 24),
              _buildSmallIconButton(
                widget.item.isFavorite ? Icons.favorite : Icons.favorite_border,
                () => setState(
                  () => widget.item.isFavorite = !widget.item.isFavorite,
                ),
                color: widget.item.isFavorite ? Colors.red : null,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSmallIconButton(
    IconData icon,
    VoidCallback onTap, {
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Icon(icon, color: color ?? Colors.grey[600], size: 22),
      ),
    );
  }
}

@riverpod
Future<List<DhikrItem>> categoryAdhkar(CategoryAdhkarRef ref, int categoryId) {
  return ref.watch(adhkarRepositoryProvider).getAdhkarByCategory(categoryId);
}
