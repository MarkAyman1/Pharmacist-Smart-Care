import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacist/core/api/api_consumer.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/auth/register/data/data/api_response.dart';
import 'package:pharmacist/features/auth/register/data/data/register_model.dart';
import 'package:pharmacist/features/auth/register/data/data/store_model.dart';

class RegisterRepository {
  final ApiConsumer api;

  RegisterRepository(this.api);
  Future<Either<Failure, RegisterResponseModel>> register({
    required String firstName,
    required String lastName,
    required String userName,
    required String phoneNumber,
    required String email,
    required String password,
    required String birthDate,
    required int gender,
    XFile? profileImage,
    required String licenseNumber,
    required String StoreId,
  }) async {
    MultipartFile? imageFile;
    if (profileImage != null) {
      if (kIsWeb) {
        var bytes = await profileImage.readAsBytes();
        imageFile = MultipartFile.fromBytes(bytes, filename: profileImage.name);
      } else {
        imageFile = await MultipartFile.fromFile(
          profileImage.path,
          filename: profileImage.name,
        );
      }
    }

    try {
      final formData = FormData.fromMap({
        "FirstName": firstName,
        "LastName": lastName,
        "UserName": userName,
        "PhoneNumber": phoneNumber,
        "Email": email,
        "Password": password,
        "Gender": gender,
        "ProfileImage": imageFile,
        "storeId": StoreId,
        "LicenseNumber": licenseNumber,
      });
      
      print('📦 Sending form data:');
      for (var f in formData.fields) {
        print('${f.key}: ${f.value}');
      }
      final response = await api.post(
        "/api/auth/Pharmacist-SignUp",
        body: formData,
        isFormData: true,
      );

      // if (data is Failure) {
      //   return Left(data);
      // }

      return Right(RegisterResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response?.data != null && e.response!.data is Map) {
        final data = e.response!.data;

        if (data["errorsBag"] != null && data["errorsBag"] is Map) {
          final bag = data["errorsBag"] as Map;
          final firstKey = bag.keys.first;
          final firstError = (bag[firstKey] as List).first;

          return Left(ServiceFailure(firstError));
        }
      }

      return Left(ServiceFailure.fromDio(e));
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  Future<List<Store>> getStores() async {
    try {
      final response = await api.get('/api/stores');

      final apiResponse = ApiResponse<List<Store>>.fromJson(response.data, (
        data,
      ) {
        if (data is List) {
          return data.map((e) => Store.fromJson(e)).toList();
        }
        return <Store>[];
      });

      if (!apiResponse.succeeded) {
        throw ServiceFailure(apiResponse.message);
      }

      return apiResponse.data ?? [];
    } on DioException catch (e) {
      throw ServiceFailure.fromDio(e);
    } catch (e) {
      throw ServiceFailure(e.toString());
    }
  }
}
