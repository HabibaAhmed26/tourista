import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  final SharedPreferences _prefs;
  PrefManager({required SharedPreferences prefs}) : _prefs = prefs;

  Future<bool> hasSeenOnboarding() async {
    return _prefs.getBool('hasSeenOnboarding') ?? false;
  }

  Future<void> setOnboardingSeen() async {
    await _prefs.setBool('hasSeenOnboarding', true);
  }

  Future<void> clearOnboardingFlag() async {
    await _prefs.remove('hasSeenOnboarding');
  }
}
