import 'package:equatable/equatable.dart';

abstract class CompaniesEvent extends Equatable {
  const CompaniesEvent();

  @override
  List<Object?> get props => [];
}

class FetchCompaniesEvent extends CompaniesEvent {}

class FetchProductsByCompanyEvent extends CompaniesEvent {
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

class IncreaseStockEvent extends CompaniesEvent {
  final String productId;
  final int quantity;

  const IncreaseStockEvent({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, quantity];
}

class DecreaseStockEvent extends CompaniesEvent {
  final String productId;
  final int quantity;

  const DecreaseStockEvent({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, quantity];
}
