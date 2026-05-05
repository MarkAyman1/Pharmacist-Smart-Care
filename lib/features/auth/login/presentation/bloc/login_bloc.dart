import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/core/services/cache_helper.dart';
import 'package:pharmacist/core/services/biometric_auth_service.dart';
import 'package:pharmacist/core/services/secure_storage_service.dart';
import 'package:pharmacist/features/auth/login/data/model/login_model.dart';
import 'package:pharmacist/features/auth/login/data/repo/login_repositry.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginButtonPressed>(loginSuccessful);
    on<BiometricLoginPressed>(biometricLogin);
  }

  Future<void> loginSuccessful(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(Loginloading());

    final Either<Failure, LoginResponseModel> result = await repository.login(
      event.email,
      event.password,
    );

    await result.fold(
      (failure) {
        emit(LoginFailed(failure.message));
      },
      (response) async {
        if (response.succeeded == true && response.data != null) {
          await CacheHelper.saveAccessToken(response.data!.accessToken!);
          await CacheHelper.saveRefreshToken(response.data!.refreshToken!);

          // Save credentials securely for biometric login
          await SecureStorageService().saveCredentials(
            email: event.email,
            password: event.password,
          );

          emit(LoginSuccess(response.data!));
        } else {
          emit(LoginFailed(response.message ?? "Login failed"));
        }
      },
    );
  }

  Future<void> biometricLogin(
    BiometricLoginPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(Loginloading());

    // Check if biometric is available
    final bool isAvailable = await BiometricAuthService.isBiometricAvailable();
    if (!isAvailable) {
      emit(LoginFailed('Biometric authentication not available'));
      return;
    }

    // Check if credentials are saved
    final credentials = await SecureStorageService().getCredentials();
    if (credentials == null) {
      emit(LoginFailed('No saved credentials. Please login first.'));
      return;
    }

    // Authenticate using biometrics
    final bool authenticated = await BiometricAuthService.authenticate(
      localizedReason: 'Verify your biometrics to login',
    );

    if (!authenticated) {
      emit(LoginFailed('Biometric authentication failed'));
      return;
    }

    // Use saved credentials to login
    final Either<Failure, LoginResponseModel> result = await repository.login(
      credentials['email']!,
      credentials['password']!,
    );

    await result.fold(
      (failure) {
        emit(LoginFailed(failure.message));
      },
      (response) async {
        if (response.succeeded == true && response.data != null) {
          await CacheHelper.saveAccessToken(response.data!.accessToken!);
          await CacheHelper.saveRefreshToken(response.data!.refreshToken!);

          emit(LoginSuccess(response.data!));
        } else {
          emit(LoginFailed(response.message ?? "Biometric login failed"));
        }
      },
    );
  }
}
