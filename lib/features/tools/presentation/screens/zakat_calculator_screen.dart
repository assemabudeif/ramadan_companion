import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

class ZakatCalculatorScreen extends StatefulWidget {
  const ZakatCalculatorScreen({super.key});

  @override
  State<ZakatCalculatorScreen> createState() => _ZakatCalculatorScreenState();
}

class _ZakatCalculatorScreenState extends State<ZakatCalculatorScreen> {
  final _cashController = TextEditingController();
  final _goldController = TextEditingController();
  final _silverController = TextEditingController();
  final _otherController = TextEditingController();

  double _totalZakat = 0.0;
  final double _zakatRate = 0.025; // 2.5%

  void _calculate() {
    final cash = double.tryParse(_cashController.text) ?? 0;
    final gold = double.tryParse(_goldController.text) ?? 0;
    final silver = double.tryParse(_silverController.text) ?? 0;
    final other = double.tryParse(_otherController.text) ?? 0;

    // Simplified calculation for UI demo
    // In real app, gold/silver would need current price per gram
    const goldPrice = 20.0; // Placeholder price
    const silverPrice = 0.5; // Placeholder price

    final totalAssets =
        cash + (gold * goldPrice) + (silver * silverPrice) + other;

    setState(() {
      _totalZakat = totalAssets * _zakatRate;
    });
  }

  @override
  void dispose() {
    _cashController.dispose();
    _goldController.dispose();
    _silverController.dispose();
    _otherController.dispose();
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
          'حاسبة الزكاة',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Result Card
            _buildResultCard(),
            const SizedBox(height: 32),

            Text(
              'أدخل قيمة أصولك',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),

            _buildInputField(
              'الأموال النقدية والمدخرات',
              _cashController,
              Icons.account_balance_wallet_outlined,
            ),
            _buildInputField(
              'الذهب (بالجرام)',
              _goldController,
              Icons.workspace_premium_outlined,
            ),
            _buildInputField(
              'الفضة (بالجرام)',
              _silverController,
              Icons.stars_outlined,
            ),
            _buildInputField(
              'أسهم، تجارة، أو أصول أخرى',
              _otherController,
              Icons.trending_up,
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: Text(
                'احسب الزكاة الآن',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),
            _buildInfoNotice(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF046D39)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'مبلغ الزكاة المستحق',
            style: GoogleFonts.cairo(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_totalZakat.toStringAsFixed(2)} ${"د.ك"}',
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, color: Colors.white70, size: 16),
                const SizedBox(width: 8),
                Text(
                  'بناءً على نسبة ٢.٥٪',
                  style: GoogleFonts.cairo(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(fontSize: 13, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.accent.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: AppColors.accent),
              const SizedBox(width: 12),
              Text(
                'تنبيه هام',
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'وجبت الزكاة إذا بلغ المال النصاب (ما يعادل قيمة ٨٥ جرام من الذهب) وحال عليه الحول (سنة قمرية كاملة).',
            style: GoogleFonts.cairo(
              fontSize: 12,
              color: Colors.grey[700],
              height: 1.6,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
