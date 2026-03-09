import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static const String _accessTokenKey = 'accessToken';
  static const String _refreashTokenKey = 'refreahToken';
  static const String _userIdKey = 'userId';

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveAccessToken(String token) async {
    await _sharedPreferences.setString(_accessTokenKey, token);
    print('🔑 Access Token saved: $token');
  }

  static Future<void> removeAccessToken() async {
    await _sharedPreferences.remove(_accessTokenKey);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _sharedPreferences.setString(_refreashTokenKey, token);
    print('🔑 Access Token saved: $token');
  }

  static String? getRefreshToken() {
    return _sharedPreferences.getString(_refreashTokenKey);
  }

  static String? getAccessToken() {
    return _sharedPreferences.getString(_accessTokenKey);
  }

  static Future<void> saveUserId(String userId) async {
    await _sharedPreferences.setString(_userIdKey, userId);
    print('🔑 User ID saved: $userId');
  }

  static String? getUserId() {
    return _sharedPreferences.getString(_userIdKey);
  }

  static Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }

  // ================= Onboarding =================

  static const String _onboardingKey = 'onboarding_completed';

  static Future<void> saveOnboardingCompleted() async {
    await _sharedPreferences.setBool(_onboardingKey, true);
  }

  static bool isOnboardingCompleted() {
    return _sharedPreferences.getBool(_onboardingKey) ?? false;
  }
  // ================= Generic Bool =================

static Future<void> saveBool({
  required String key,
  required bool value,
}) async {
  await _sharedPreferences.setBool(key, value);
}

static bool? getBool(String key) {
  return _sharedPreferences.getBool(key);
}
}
