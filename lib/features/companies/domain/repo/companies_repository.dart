import 'package:dio/dio.dart';
import 'package:pharmacist/core/api/api_consumer.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/companies/domain/models/company_model.dart';
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
  
}
