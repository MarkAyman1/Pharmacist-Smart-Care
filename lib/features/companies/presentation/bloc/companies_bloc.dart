import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/failure.dart';
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
    // ================= GET PRODUCTS =================
    on<FetchProductsByCompanyEvent>((event, emit) async {
      emit(ProductsLoading());

      try {
        final products = await repository.getProductsByCompany(
          companyId: event.companyId,
          pageNumber: event.pageNumber,
          pageSize: event.pageSize,
        );

        emit(ProductsLoaded(products));
      } catch (e) {
        print("🔥 ERROR: $e");
        if (e is ServiceFailure) {
          emit(CompaniesError(message: e.message));
        } else {
          emit(const CompaniesError(message: "Unexpected error"));
        }
      }
    });

    on<IncreaseStockEvent>((event, emit) async {
      try {
        await repository.increaseStock(
          productId: event.productId,
          quantity: event.quantity,
        );

        final currentState = state;

        if (currentState is ProductsLoaded) {
          emit(StockUpdated("Stock increased successfully"));

          // رجّع نفس الداتا تاني
          emit(currentState);
        }
      } catch (e) {
        emit(CompaniesError(message: e.toString()));
      }
    });

    on<DecreaseStockEvent>((event, emit) async {
      try {
        await repository.decreaseStock(
          productId: event.productId,
          quantity: event.quantity,
        );

        final currentState = state;

        if (currentState is ProductsLoaded) {
          emit(StockUpdated("Stock decreased successfully"));
          emit(currentState);
        }
      } catch (e) {
        emit(CompaniesError(message: e.toString()));
      }
    });
  }
}
