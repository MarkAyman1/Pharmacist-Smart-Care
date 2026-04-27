import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/features/profile_drawer/blocs/profile_event.dart';
import 'package:pharmacist/core/features/profile_drawer/blocs/profile_state.dart';
import 'package:pharmacist/core/features/profile_drawer/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await repository.getProfile();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }
}