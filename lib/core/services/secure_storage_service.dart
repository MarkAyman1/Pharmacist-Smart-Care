import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  static const String _emailKey = 'pharmacist_email';
  static const String _passwordKey = 'pharmacist_password';
  static const String _shouldRememberKey = 'pharmacist_should_remember';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // In-memory fallback storage if secure storage fails
  static final Map<String, String> _memoryStorage = {};

  SecureStorageService._internal();

  factory SecureStorageService() {
    return _instance;
  }

  /// Save credentials for biometric login
  Future<void> saveCredentials({
    required String email,
    required String password,
  }) async {
    try {
      await _storage.write(key: _emailKey, value: email);
      await _storage.write(key: _passwordKey, value: password);
      await _storage.write(key: _shouldRememberKey, value: 'true');
      print('✅ Credentials saved securely');
    } catch (e) {
      print('⚠️ Secure storage unavailable, using memory cache: $e');
      _memoryStorage[_emailKey] = email;
      _memoryStorage[_passwordKey] = password;
      _memoryStorage[_shouldRememberKey] = 'true';
    }
  }

  /// Retrieve saved email
  Future<String?> getSavedEmail() async {
    try {
      final value = await _storage.read(key: _emailKey);
      if (value != null) return value;
    } catch (e) {
      print('⚠️ Error retrieving email from secure storage: $e');
    }

    // Fallback to memory storage
    return _memoryStorage[_emailKey];
  }

  /// Retrieve saved password
  Future<String?> getSavedPassword() async {
    try {
      final value = await _storage.read(key: _passwordKey);
      if (value != null) return value;
    } catch (e) {
      print('⚠️ Error retrieving password from secure storage: $e');
    }

    // Fallback to memory storage
    return _memoryStorage[_passwordKey];
  }

  /// Check if credentials should be remembered
  Future<bool> shouldRememberCredentials() async {
    try {
      final value = await _storage.read(key: _shouldRememberKey);
      if (value != null) return value == 'true';
    } catch (e) {
      print('⚠️ Error checking remember flag: $e');
    }

    // Fallback to memory storage
    return _memoryStorage[_shouldRememberKey] == 'true';
  }

  /// Clear saved credentials
  Future<void> clearCredentials() async {
    try {
      await _storage.delete(key: _emailKey);
      await _storage.delete(key: _passwordKey);
      await _storage.delete(key: _shouldRememberKey);
      print('✅ Credentials cleared');
    } catch (e) {
      print('⚠️ Error clearing credentials: $e');
    }

    // Clear memory storage
    _memoryStorage.clear();
  }

  /// Get both credentials for login
  Future<Map<String, String>?> getCredentials() async {
    try {
      final email = await getSavedEmail();
      final password = await getSavedPassword();

      if (email != null && password != null) {
        return {'email': email, 'password': password};
      }
      return null;
    } catch (e) {
      print('⚠️ Error retrieving credentials: $e');
      return null;
    }
  }
}
