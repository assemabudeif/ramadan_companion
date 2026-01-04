import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _counter = 0;
  int _target = 33;
  String _dhikr = 'سبحان الله';

  void _increment() {
    HapticFeedback.lightImpact();
    setState(() {
      _counter++;
    });
    if (_counter == _target) {
      HapticFeedback.heavyImpact();
      _showCompletionEffect();
    }
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  void _showCompletionEffect() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم الانتهاء من $_target تسبيحة',
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.accent,
        duration: const Duration(seconds: 1),
      ),
    );
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
          'المسبحة الإلكترونية',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _reset,
            icon: const Icon(Icons.refresh, color: AppColors.primary),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          _buildDhikrSelector(),
          const Spacer(),
          _buildCounterDisplay(),
          const Spacer(),
          _buildTapArea(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildDhikrSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            _dhikr,
            style: GoogleFonts.amiri(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              children: [
                _targetChip(33),
                _targetChip(99),
                _targetChip(100),
                _targetChip(1000),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _targetChip(int val) {
    bool isSelected = _target == val;
    return GestureDetector(
      onTap: () => setState(() => _target = val),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[200]!,
          ),
        ),
        child: Text(
          '$val',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildCounterDisplay() {
    double progress = (_counter % _target) / _target;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 15,
            strokeCap: StrokeCap.round,
            backgroundColor: Colors.white,
            color: AppColors.accent,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_counter',
              style: GoogleFonts.manrope(
                fontSize: 80,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            Text(
              'من $_target',
              style: GoogleFonts.cairo(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTapArea() {
    return GestureDetector(
      onTap: _increment,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(
          Icons.touch_app_outlined,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
