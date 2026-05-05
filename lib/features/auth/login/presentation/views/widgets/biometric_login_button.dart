import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/services/biometric_auth_service.dart';
import 'package:pharmacist/core/services/secure_storage_service.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_state.dart';

class BiometricLoginButton extends StatefulWidget {
  const BiometricLoginButton({super.key});

  @override
  State<BiometricLoginButton> createState() => _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends State<BiometricLoginButton> {
  bool _isBiometricAvailable = false;
  bool _hasCredentialsSaved = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    final isAvailable = await BiometricAuthService.isBiometricAvailable();
    final credentials = await SecureStorageService().getCredentials();
    
    setState(() {
      _isBiometricAvailable = isAvailable;
      _hasCredentialsSaved = credentials != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isBiometricAvailable) {
      return const SizedBox.shrink(); // Don't show button if biometric not available
    }

    if (!_hasCredentialsSaved) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Login with email first to enable biometric login',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state is Loginloading
              ? null
              : () {
                  context.read<LoginBloc>().add(BiometricLoginPressed());
                },
          icon: const Icon(Icons.fingerprint),
          label: Text(state is Loginloading ? 'Authenticating...' : 'Login with Biometrics'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}