import 'package:dio/dio.dart';
import 'package:pharmacist/core/api/api_consumer.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/categories/domain/models/category_model.dart';

class CategoriesRepository {
  final ApiConsumer apiConsumer;

  CategoriesRepository(this.apiConsumer);

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await apiConsumer.get('/api/categories');
      final data = response.data['data'] as List<dynamic>;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServiceFailure.fromDio(e);
    }
  }
}