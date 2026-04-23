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
      // Handle errorsBag (like {"VerifyCode": ["message1", "message2"]})
      if (data.containsKey("errorsBag")) {
        final errorsBag = data["errorsBag"];

        if (errorsBag is Map<String, dynamic>) {
          // Get all error messages from all keys
          final allMessages = <String>[];
          for (final errors in errorsBag.values) {
            if (errors is List) {
              allMessages.addAll(errors.map((e) => e.toString()));
            } else if (errors is String) {
              allMessages.add(errors);
            }
          }
          if (allMessages.isNotEmpty) {
            return allMessages.join('\n');
          }
        }
      }

      // Handle standard errors (like {"errors": {"field": ["message"]}})
      if (data.containsKey("errors")) {
        final errors = data["errors"];

        if (errors is Map<String, dynamic>) {
          // Get first error from first key
          final firstError = errors.values.first;

          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
        }
      }

      // Handle message
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
