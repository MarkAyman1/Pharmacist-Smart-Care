import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/auth/register/data/repo/register_repository.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository repository;

  RegisterBloc(this.repository) : super(RegisterInitial()) {
    on<LoadStores>(_onLoadStores);
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onLoadStores(
    LoadStores event,
    Emitter<RegisterState> emit,
  ) async {
    emit(StoresLoading());
    try {
      final stores = await repository.getStores();
      emit(StoresLoaded(stores));
    } catch (e) {
      if (e is ServiceFailure) {
        emit(StoresFailure(e.message));
      } else {
        emit(StoresFailure(e.toString()));
      }
    }
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final result = await repository.register(
        firstName: event.firstName,
        lastName: event.lastName,
        userName: event.username,
        phoneNumber: event.phoneNumber,
        email: event.email,
        password: event.password,
        birthDate: event.birthDate,
        gender: event.gender,
        profileImage: event.profileImage,
        licenseNumber: event.licenseNumber,
        StoreId: event.storeId,
      );

      result.fold(
        (failure) => emit(RegisterFailure(failure.message)),
        (data) => emit(RegisterSuccess(data)),
      );
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
