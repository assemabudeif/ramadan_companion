import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:adhan/adhan.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  double? _qiblaDirection;
  double? _distance;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _initLocationAndQibla();
  }

  Future<void> _initLocationAndQibla() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _error = 'خدمة الموقع غير مفعلة';
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _error = 'تم رفض الإذن بالوصول للموقع';
            _isLoading = false;
          });
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();
      final coordinates = Coordinates(position.latitude, position.longitude);
      final qibla = Qibla(coordinates);
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        21.4225,
        39.8262,
      );

      setState(() {
        _qiblaDirection = qibla.direction;
        _distance = distance / 1000; // Convert to km
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ في تحديد الموقع';
        _isLoading = false;
      });
    }
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
          'اتجاه القبلة',
          style: GoogleFonts.cairo(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
          ? _buildErrorView()
          : _buildCompassView(),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(_error, style: GoogleFonts.cairo(color: Colors.grey[700])),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _initLocationAndQibla,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text(
              'إعادة المحاولة',
              style: GoogleFonts.cairo(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompassView() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final heading = snapshot.data?.heading;
        if (heading == null) {
          return const Center(child: Text('جهازك لا يدعم البوصلة'));
        }

        // Qibla Relative to North
        final qiblaRelToNorth = _qiblaDirection ?? 0;

        // Smoothed Animation Logic
        final compassRotation = -heading * (math.pi / 180);

        // Alignment Threshold (5 degrees)
        final isAligned = (qiblaRelToNorth - heading).abs() % 360 < 5;

        return Column(
          children: [
            const SizedBox(height: 40),
            _buildDistanceCard(isAligned),
            const Spacer(),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Alignment Glow
                  if (isAligned)
                    Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),

                  // Compass Dial (Background)
                  AnimatedRotation(
                    turns: compassRotation / (2 * math.pi),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: Image.asset(
                      'assets/images/qibla_dial.png',
                      width: 300,
                      height: 300,
                    ),
                  ),

                  // Qibla Needle
                  AnimatedRotation(
                    turns:
                        compassRotation / (2 * math.pi) +
                        (qiblaRelToNorth / 360),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: Image.asset(
                      'assets/images/qibla_needle.png',
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _buildInstructionCard(),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildDistanceCard(bool isAligned) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isAligned ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (isAligned ? AppColors.primary : Colors.black).withOpacity(
              0.1,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: isAligned ? Colors.white : AppColors.accent,
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text(
                isAligned ? 'أنت الآن باتجاه القبلة' : 'المسافة إلى الكعبة',
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: isAligned ? Colors.white70 : Colors.grey,
                ),
              ),
              Text(
                '${_distance?.toStringAsFixed(0)} كم',
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isAligned ? Colors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            'ضع هاتفك على سطح مستوٍ للحصول على أفضل دقة',
            style: GoogleFonts.cairo(fontSize: 11, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
