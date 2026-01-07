import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class DuaLibraryScreen extends StatelessWidget {
  const DuaLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'مكتبة الأدعية',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            TextFormField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'ابحث في الأدعية...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            _buildCategorySection('أدعية القرآن الكريم', [
              _DuaCardData('ربنا آتنا في الدنيا حسنة...', 'سورة البقرة - ٢٠١'),
              _DuaCardData('ربنا لا تؤاخذنا إن نسينا...', 'سورة البقرة - ٢٨٦'),
            ]),

            const SizedBox(height: 24),

            _buildCategorySection('أدعية الأنبياء عليهم السلام', [
              _DuaCardData(
                'لا إله إلا أنت سبحانك إني كنت من الظالمين',
                'دعاء ذي النون',
              ),
              _DuaCardData(
                'رب إني لما أنزلت إلي من خير فقير',
                'دعاء موسى عليه السلام',
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<_DuaCardData> duas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 12),
        ...duas.map((dua) => _buildDuaCard(dua)).toList(),
      ],
    );
  }

  Widget _buildDuaCard(_DuaCardData dua) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            dua.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Amiri',
              fontSize: 20,
              height: 1.6,
              color: Color(0xFF2D2D2D),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  size: 20,
                  color: AppColors.accent,
                ),
                onPressed: () {},
              ),
              Text(
                dua.source,
                style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DuaCardData {
  final String text;
  final String source;
  _DuaCardData(this.text, this.source);
}
