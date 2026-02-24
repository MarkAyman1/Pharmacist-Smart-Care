import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServiceFailure extends Failure {
  const ServiceFailure(super.message);

  factory ServiceFailure.fromDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ServiceFailure("Connection timeout");
      case DioExceptionType.receiveTimeout:
        return const ServiceFailure("Receive timeout");
      case DioExceptionType.sendTimeout:
        return const ServiceFailure("Send timeout");
      case DioExceptionType.connectionError:
        return const ServiceFailure("No Internet connection");
      case DioExceptionType.badResponse:
        return ServiceFailure(
          error.response?.data['message'] ?? "Server error",
        );
      default:
        return const ServiceFailure("Unexpected error occurred");
    }
  }
}