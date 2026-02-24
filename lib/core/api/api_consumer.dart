import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> post(
    String endpoint, {
    dynamic body,
    bool isFormData = false,
  });

  Future<Response> put(
    String endpoint, {
    dynamic body,
    bool isFormData = false,
  });

  Future<Response> patch(
    String endpoint, {
    dynamic body,
  });

  Future<Response> delete(
    String endpoint, {
    dynamic body,
  });
}