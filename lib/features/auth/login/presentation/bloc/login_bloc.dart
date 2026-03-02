import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/auth/login/data/model/login_model.dart';
import 'package:pharmacist/features/auth/login/data/repo/login_repositry.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginButtonPressed>(_LoginSuccess);
  }

  Future<void> _LoginSuccess(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(Loginloading());

    final Either<Failure, LoginResponseModel> result = await repository.login(
      event.email,
      event.password,
    );

    result.fold(
      (failure) {
        emit(LoginFailed(failure.message));
      },
      (response) {
        if (response.succeeded == true && response.data != null) {
          emit(LoginSuccess(response.data!));
        } else {
          emit(LoginFailed(response.message ?? "Login failed"));
        }
      },
    );
  }
}
