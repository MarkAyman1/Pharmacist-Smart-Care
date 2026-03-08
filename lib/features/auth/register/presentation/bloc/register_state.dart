import 'package:equatable/equatable.dart';
import 'package:pharmacist/features/auth/register/data/data/register_model.dart';
import 'package:pharmacist/features/auth/register/data/data/store_model.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponseModel data;
  const RegisterSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class RegisterFailure extends RegisterState {
  final String error;
  const RegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// States for Stores
class StoresLoading extends RegisterState {}

class StoresLoaded extends RegisterState {
  final List<Store> stores;
  const StoresLoaded(this.stores);

  @override
  List<Object?> get props => [stores];
}

class StoresFailure extends RegisterState {
  final String error;
  const StoresFailure(this.error);

  @override
  List<Object?> get props => [error];
}
