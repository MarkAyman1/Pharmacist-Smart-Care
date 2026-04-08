import 'package:dio/dio.dart';
import 'package:pharmacist/core/api/api_consumer.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/products/domain/model/pagination_model.dart';

class ProductsRepository {
  final ApiConsumer apiConsumer;

  ProductsRepository(this.apiConsumer);

  // ================== GET PRODUCTS BY CATEGORY ==================
  Future<PaginatedProducts> getProductsByCategory({
    required String categoryId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await apiConsumer.get(
        '/api/Pharmacist/Products/Category/Store',
        queryParameters: {
          "categoryId": categoryId,
          "pageNumber": pageNumber,
          "pageSize": pageSize,
        },
      );

      final data = response.data['data'];
      return PaginatedProducts.fromJson(data);
    } on DioException catch (e) {
      throw ServiceFailure.fromDio(e);
    }
  }

  // ================== GET PRODUCTS BY COMPANY ==================
  Future<PaginatedProducts> getProductsByCompany({
    required String companyId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await apiConsumer.get(
        '/api/Pharmacist/Products/Company/Store',
        queryParameters: {
          "companyId": companyId,
          "pageNumber": pageNumber,
          "pageSize": pageSize,
        },
      );

      final data = response.data['data'];
      return PaginatedProducts.fromJson(data);
    } on DioException catch (e) {
      throw ServiceFailure.fromDio(e);
    }
  }

  // ================== STOCK OPERATIONS ==================
  Future<bool> increaseStock({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await apiConsumer.patch(
        '/api/Pharmacist/Inventories/IncreaseStockInStore',
        queryParameters: {"productId": productId, "quantityToAdd": quantity},
      );
      return response.data['data'];
    } on DioException catch (e) {
      throw ServiceFailure.fromDio(e);
    }
  }

  Future<bool> decreaseStock({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await apiConsumer.patch(
        '/api/Pharmacist/Inventories/DecreaseStockInStore',
        queryParameters: {"productId": productId, "quantityToRemove": quantity},
      );
      return response.data['data'];
    } on DioException catch (e) {
      throw ServiceFailure.fromDio(e);
    }
  }
}
