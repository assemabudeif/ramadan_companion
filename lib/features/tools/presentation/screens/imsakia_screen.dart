import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class ImsakiaScreen extends StatelessWidget {
  const ImsakiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'إمساكية رمضان',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildLocationHeader(),
          const SizedBox(height: 16),
          _buildTableHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 30,
              itemBuilder: (context, index) => _buildImsakiaRow(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الكويت، مدينة الكويت',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'رمضان ١٤٤٦ هـ',
                  style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'تغيير',
              style: GoogleFonts.cairo(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _headerText('اليوم', 1),
          _headerText('فجر', 1),
          _headerText('شروق', 1),
          _headerText('ظهر', 1),
          _headerText('عصر', 1),
          _headerText('مغرب', 1),
          _headerText('عشاء', 1),
        ],
      ),
    );
  }

  Widget _headerText(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.cairo(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImsakiaRow(int index) {
    final isToday = index == 4; // Mock today
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isToday ? AppColors.accent.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isToday ? Border.all(color: AppColors.accent, width: 1) : null,
      ),
      child: Row(
        children: [
          _rowText('${index + 1}', 1, isBold: true),
          _rowText('04:33', 1),
          _rowText('05:58', 1),
          _rowText('12:15', 1),
          _rowText('15:45', 1),
          _rowText('18:20', 1),
          _rowText('19:40', 1),
        ],
      ),
    );
  }

  Widget _rowText(String text, int flex, {bool isBold = false}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isBold ? AppColors.primary : Colors.black87,
        ),
      ),
    );
  }
}
