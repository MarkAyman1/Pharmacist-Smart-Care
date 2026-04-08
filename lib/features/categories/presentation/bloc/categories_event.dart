import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends CategoriesEvent {}

class FetchProductsByCategoryEvent extends CategoriesEvent {
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

class IncreaseStockEvent extends CategoriesEvent {
  final String productId;
  final int quantity;

  const IncreaseStockEvent({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, quantity];
}

class DecreaseStockEvent extends CategoriesEvent {
  final String productId;
  final int quantity;

  const DecreaseStockEvent({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, quantity];
}
