import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _counter = 0;
  int _target = 33;
  String _dhikr = 'سبحان الله';

  final List<String> _dhikrOptions = [
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
    'أستغفر الله',
    'لا حول ولا قوة إلا بالله',
    'اللهم صل على محمد',
  ];

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('tasbeeh_counter') ?? 0;
      _target = prefs.getInt('tasbeeh_target') ?? 33;
      _dhikr = prefs.getString('tasbeeh_dhikr') ?? 'سبحان الله';
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbeeh_counter', _counter);
    await prefs.setInt('tasbeeh_target', _target);
    await prefs.setString('tasbeeh_dhikr', _dhikr);
  }

  void _increment() {
    HapticFeedback.lightImpact();
    setState(() {
      _counter++;
    });
    _saveState();

    // Check for target completion
    if (_counter % _target == 0 && _counter > 0) {
      HapticFeedback.heavyImpact();
      _showCompletionEffect();
    }
  }

  void _reset() {
    HapticFeedback.mediumImpact();
    setState(() {
      _counter = 0;
    });
    _saveState();
  }

  void _setTarget(int val) {
    setState(() {
      _target = val;
    });
    _saveState();
  }

  void _showCompletionEffect() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم الانتهاء من $_target تسبيحة',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDhikrSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'اختر الذكر',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _dhikrOptions.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final dhikr = _dhikrOptions[index];
                    return ListTile(
                      title: Text(
                        dhikr,
                        style: GoogleFonts.amiri(
                          fontSize: 20,
                          fontWeight: _dhikr == dhikr
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: _dhikr == dhikr
                              ? AppColors.primary
                              : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      trailing: _dhikr == dhikr
                          ? const Icon(Icons.check, color: AppColors.primary)
                          : null,
                      onTap: () {
                        setState(() {
                          _dhikr = dhikr;
                          _counter = 0; // Reset on change
                        });
                        _saveState();
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
        ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }

  Widget _buildDhikrSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          InkWell(
            onTap: _showDhikrSelection,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _dhikr,
                    style: GoogleFonts.amiri(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
      onTap: () => _setTarget(val),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[200]!,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
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
    double progress = _target > 0 ? (_counter % _target) / _target : 0;
    if (progress == 0 && _counter > 0 && _counter % _target == 0)
      progress = 1.0;

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
