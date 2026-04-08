import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/categories/domain/repo/categories_repository.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_event.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository repository;

  CategoriesBloc(this.repository) : super(CategoriesInitial()) {
    on<FetchCategoriesEvent>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final categories = await repository.getCategories();
        emit(CategoriesLoaded(categories: categories));
      } catch (e) {
        emit(CategoriesError(message: e.toString()));
      }
    });
    // ================= GET PRODUCTS =================
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
        print("🔥 ERROR: $e");
        if (e is ServiceFailure) {
          emit(CategoriesError(message: e.message));
        } else {
          emit(const CategoriesError(message: "Unexpected error"));
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
        emit(CategoriesError(message: e.toString()));
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
        emit(CategoriesError(message: e.toString()));
      }
    });
  }
}
