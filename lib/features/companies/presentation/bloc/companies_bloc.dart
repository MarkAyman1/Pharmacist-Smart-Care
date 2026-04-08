import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/companies/domain/repo/companies_repository.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_event.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_state.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  final CompaniesRepository repository;

  CompaniesBloc(this.repository) : super(CompaniesInitial()) {
    on<FetchCompaniesEvent>((event, emit) async {
      emit(CompaniesLoading());
      try {
        final companies = await repository.getCompanies();
        emit(CompaniesLoaded(companies: companies));
      } catch (e) {
        emit(CompaniesError(message: e.toString()));
      }
    });

    
  }
}
