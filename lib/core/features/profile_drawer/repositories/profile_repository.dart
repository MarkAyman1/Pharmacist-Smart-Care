import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharmacist/core/api/api_consumer.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/core/features/profile_drawer/models/profile_model.dart';

class ProfileRepository {
  final ApiConsumer api;

  ProfileRepository(this.api);

  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final response = await api.get("/api/pharmacist/profile");

      if (response.statusCode == 200 &&
          response.data['succeeded'] == true &&
          response.data['data'] != null) {
        return Right(ProfileModel.fromJson(response.data['data']));
      } else {
        return Left(
          ServiceFailure(response.data['message'] ?? "Failed to load profile"),
        );
      }
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDio(e));
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }
}
