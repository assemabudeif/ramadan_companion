import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';

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
      final qibla = _calculateQibla(position.latitude, position.longitude);
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        21.4225,
        39.8262,
      );

      setState(() {
        _qiblaDirection = qibla;
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

  double _calculateQibla(double lat, double lng) {
    const kaabaLat = 21.4225;
    const kaabaLng = 39.8262;

    final phi1 = lat * math.pi / 180;
    final lambda1 = lng * math.pi / 180;
    final phi2 = kaabaLat * math.pi / 180;
    final lambda2 = kaabaLng * math.pi / 180;

    final y = math.sin(lambda2 - lambda1);
    final x =
        math.cos(phi1) * math.tan(phi2) -
        math.sin(phi1) * math.cos(lambda2 - lambda1);

    return math.atan2(y, x) * 180 / math.pi;
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

        final direction = snapshot.data?.heading;
        if (direction == null) {
          return const Center(child: Text('جهازك لا يدعم البوصلة'));
        }

        // The angle to rotate the dial so North is up relative to device
        final dialRotation = -direction * (math.pi / 180);
        // The angle of the Qibla arrow relative to the dial
        final qiblaAngle = (_qiblaDirection ?? 0) * (math.pi / 180);

        return Column(
          children: [
            const SizedBox(height: 40),
            _buildDistanceCard(),
            const Spacer(),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Compass Dial
                  Transform.rotate(
                    angle: dialRotation,
                    child: Image.asset(
                      'assets/images/qibla_dial.png',
                      width: 320,
                      height: 320,
                    ),
                  ),
                  // Qibla Needle (Orients towards Kaaba)
                  Transform.rotate(
                    angle: dialRotation + qiblaAngle,
                    child: Image.asset(
                      'assets/images/qibla_needle.png',
                      width: 280,
                      height: 280,
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

  Widget _buildDistanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, color: AppColors.accent),
          const SizedBox(width: 12),
          Column(
            children: [
              Text(
                'المسافة إلى الكعبة',
                style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
              ),
              Text(
                '${_distance?.toStringAsFixed(0)} كم',
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
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
