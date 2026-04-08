import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/products/domain/repo/products_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;

  ProductsBloc(this.repository) : super(ProductsInitial()) {
    // ====== Fetch products by category ======
    on<FetchProductsByCategoryEvent>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await repository.getProductsByCategory(
          categoryId: event.categoryId,
          pageNumber: event.pageNumber,
          pageSize: event.pageSize,
        );
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductsError(message: e.toString()));
      }
    });

    // ====== Fetch products by company ======
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
        if (e is ServiceFailure) {
          emit(ProductsError(message: e.message));
        } else {
          emit(const ProductsError(message: "Unexpected error"));
        }
      }
    });

    // ====== Stock operations ======
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
        emit(ProductsError(message: e.toString()));
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
        emit(ProductsError(message: e.toString()));
      }
    });
  }
}
