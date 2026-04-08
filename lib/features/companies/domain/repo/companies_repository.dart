import 'package:dio/dio.dart';
import 'package:pharmacist/core/api/api_consumer.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/companies/domain/models/company_model.dart';
import 'package:pharmacist/features/products/model/pagination_model.dart';

class CompaniesRepository {
  final ApiConsumer apiConsumer;

  CompaniesRepository(this.apiConsumer);

  Future<List<CompanyModel>> getCompanies() async {
    try {
      final response = await apiConsumer.get('/api/companies');
      final data = response.data['data'] as List<dynamic>;
      return data.map((e) => CompanyModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServiceFailure.fromDio(e);
    }
  }
  // ================= PRODUCTS =================

  Future<PaginatedProducts> getProductsByCompany({
    required String companyId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await apiConsumer.get(
        '/api/Pharmacist/Products/Company/Store',
        queryParameters: {
          "categoryId": companyId,
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

  // ================= STOCK =================

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
