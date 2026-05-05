import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// Check if biometric authentication is available on the device
  static Future<bool> isBiometricAvailable() async {
    try {
      final List<BiometricType> availableBiometrics = await _auth
          .getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } catch (e) {
      print('Error checking biometric availability: $e');
      return false;
    }
  }

  /// Get list of available biometric types
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      print('Error getting available biometrics: $e');
      return [];
    }
  }

  /// Authenticate using biometrics
  static Future<bool> authenticate({
    required String localizedReason,
    String? authErrorDescription,
    String? biometricOnlyTitle,
    String? goToSettingsButtonText,
    String? goToSettingsDescription,
    String? cancelButtonText,
  }) async {
    try {
      final bool authenticated = await _auth.authenticate(
        localizedReason: localizedReason,
      );
      return authenticated;
    } catch (e) {
      print('Error during biometric authentication: $e');
      return false;
    }
  }
}
