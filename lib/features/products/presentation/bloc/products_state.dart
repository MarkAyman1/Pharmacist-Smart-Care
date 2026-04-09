import 'package:equatable/equatable.dart';
import 'package:pharmacist/features/products/domain/model/pagination_model.dart';
import 'package:pharmacist/features/products/domain/model/product_model.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

// ====== Initial ======
class ProductsInitial extends ProductsState {}

// ====== Loading ======
class ProductsLoading extends ProductsState {}

// ====== Loaded ======
class ProductsLoaded extends ProductsState {
  final PaginatedProducts products;

  const ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

// ====== Stock updated ======
class StockUpdated extends ProductsState {
  final String message;

  const StockUpdated(this.message);
}

// ====== Error ======
class ProductsError extends ProductsState {
  final String message;

  const ProductsError({required this.message});

  @override
  List<Object?> get props => [message];
}

//=====search=====
class ProductsSearchLoaded extends ProductsState {
  final List<ProductModel> products;

  const ProductsSearchLoaded(this.products);

  @override
  List<Object?> get props => [products];
}
