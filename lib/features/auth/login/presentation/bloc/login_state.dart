import 'package:pharmacist/features/auth/login/data/model/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class Loginloading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginData data;
  LoginSuccess(this.data);
}

class LoginFailed extends LoginState {
  final String error;
  LoginFailed(this.error);
}
