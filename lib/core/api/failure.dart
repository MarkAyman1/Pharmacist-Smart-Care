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
        return ServiceFailure(_handleBadResponse(error.response));

      case DioExceptionType.cancel:
        return const ServiceFailure("Request was cancelled");

      case DioExceptionType.unknown:
      default:
        return const ServiceFailure("Unexpected error occurred");
    }
  }

  static String _handleBadResponse(Response? response) {
    if (response == null) {
      return "Server error";
    }

    final data = response.data;

    if (data is Map<String, dynamic>) {
      //  لو فيه validation errors
      if (data.containsKey("errors")) {
        final errors = data["errors"];

        if (errors is Map<String, dynamic>) {
          // نجيب أول error في أول key
          final firstError = errors.values.first;

          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
        }
      }

      //  لو فيه message عادي
      if (data.containsKey("message")) {
        return data["message"].toString();
      }

      if (data.containsKey("error")) {
        return data["error"].toString();
      }
    }

    if (data is String) {
      return data;
    }

    return "Server error (${response.statusCode})";
  }
}
