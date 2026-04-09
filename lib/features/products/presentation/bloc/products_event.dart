import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

// ====== Fetch products by category ======
class FetchProductsByCategoryEvent extends ProductsEvent {
  final String categoryId;
  final int pageNumber;
  final int pageSize;

  const FetchProductsByCategoryEvent({
    required this.categoryId,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [categoryId, pageNumber, pageSize];
}

// ====== Fetch products by company ======
class FetchProductsByCompanyEvent extends ProductsEvent {
  final String companyId;
  final int pageNumber;
  final int pageSize;

  const FetchProductsByCompanyEvent({
    required this.companyId,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [companyId, pageNumber, pageSize];
}

// ====== Stock operations ======
class IncreaseStockEvent extends ProductsEvent {
  final String productId;
  final int quantity;

  const IncreaseStockEvent({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}

class DecreaseStockEvent extends ProductsEvent {
  final String productId;
  final int quantity;

  const DecreaseStockEvent({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}

// ====== Search products by name ======
class SearchProductsByNameEvent extends ProductsEvent {
  final String productName;

  const SearchProductsByNameEvent({required this.productName});

  @override
  List<Object?> get props => [productName];
}
