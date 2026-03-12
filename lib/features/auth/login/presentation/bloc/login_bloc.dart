import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/core/services/cache_helper.dart';
import 'package:pharmacist/features/auth/login/data/model/login_model.dart';
import 'package:pharmacist/features/auth/login/data/repo/login_repositry.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginButtonPressed>(loginSuccessful);
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

          emit(LoginSuccess(response.data!));
        } else {
          emit(LoginFailed(response.message ?? "Login failed"));
        }
      },
    );
  }
}
