import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharmacist/core/api/api_consumer.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/auth/login/data/model/login_model.dart';

class LoginRepository {
  final ApiConsumer api;

  LoginRepository(this.api);

  Future<Either<Failure, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await api.post(
        "/api/auth/Pharmacist-Login",
        body: {"email": email, "password": password},
        isFormData: false,
      );

      // 🔥 أهم تعديل هنا
      if (response.statusCode == 200 &&
          response.data['succeeded'] == true &&
          response.data['data'] != null) {
        return Right(LoginResponseModel.fromJson(response.data));
      } else {
        return Left(ServiceFailure(response.data['message'] ?? "Login failed"));
      }
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDio(e));
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }
}
