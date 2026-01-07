import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_profile_repository.g.dart';

@Riverpod(keepAlive: true)
UserProfileRepository userProfileRepository(UserProfileRepositoryRef ref) {
  return UserProfileRepository();
}

class UserProfileRepository {
  static const String _nameKey = 'user_profile_name';
  static const String _onboardingKey = 'onboarding_complete';

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey) ?? 'عبد الله'; // Default name
  }

  Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
  }

  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
}

// Global Providers
final userProfileRepoProvider = Provider((ref) => UserProfileRepository());

final userNameProvider = FutureProvider((ref) async {
  final repo = ref.watch(userProfileRepoProvider);
  return repo.getUserName();
});
