import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ramadan_companion/core/theme/app_theme.dart';
import 'package:ramadan_companion/features/settings/data/repositories/user_profile_repository.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _locationEnabled = false;
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final locStatus = await Permission.location.status;
    final notifStatus = await Permission.notification.status;
    if (mounted) {
      setState(() {
        _locationEnabled = locStatus.isGranted;
        _notificationsEnabled = notifStatus.isGranted;
      });
    }
  }

  Future<void> _requestLocation(bool value) async {
    if (value) {
      final status = await Permission.location.request();
      setState(() => _locationEnabled = status.isGranted);
    } else {
      openAppSettings(); // Can't revoke programmatically, guide user
      setState(() => _locationEnabled = false); // Optimistic UI update
    }
  }

  Future<void> _requestNotifications(bool value) async {
    if (value) {
      final status = await Permission.notification.request();
      setState(() => _notificationsEnabled = status.isGranted);
    } else {
      openAppSettings();
      setState(() => _notificationsEnabled = false);
    }
  }

  Future<void> _completeOnboarding() async {
    // Save onboarding complete
    final repo = ref.read(userProfileRepoProvider);
    await repo.setOnboardingComplete();

    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mosque Illustration Container
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/onboarding_mosque_illustration.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.mosque,
                              color: AppColors.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'رمضان كريم',
                              style: GoogleFonts.cairo(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Welcome Text
              Text(
                'مرحباً بك في\nرفيق رمضان',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'دليلك الروحي للشهر الفضيل. دعنا نجهز تجربتك للحصول على أوقات صلاة وتذكيرات دقيقة.',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // Permissions Section
              _buildPermissionTile(
                icon: Icons.location_on,
                title: 'تفعيل الموقع',
                subtitle:
                    'للحصول على أوقات صلاة دقيقة واتجاه القبلة حسب موقعك.',
                value: _locationEnabled,
                onChanged: _requestLocation,
              ),
              const SizedBox(height: 16),
              _buildPermissionTile(
                icon: Icons.notifications_active,
                title: 'تفعيل الإشعارات',
                subtitle:
                    'احصل على تنبيهات السحور والإفطار ولا تفوت الأوقات المباركة.',
                value: _notificationsEnabled,
                onChanged: _requestNotifications,
              ),

              const SizedBox(height: 40),

              // Start Button
              ElevatedButton(
                onPressed: _completeOnboarding,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ابدأ الآن',
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Text(
                'باستمرارك، فإنك توافق على شروط الخدمة وسياسة الخصوصية.',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
