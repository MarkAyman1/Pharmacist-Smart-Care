import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'api_config.dart';
import 'api_consumer.dart';
import 'api_interceptor.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
    );

    dio.interceptors.add(ApiInterceptor(dio));

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    if (kDebugMode) {
      (dio.httpClientAdapter as IOHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  @override
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    return dio.get(endpoint, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(String endpoint,
      {dynamic body, bool isFormData = false}) {
    return dio.post(endpoint, data: body);
  }

  @override
  Future<Response> put(String endpoint,
      {dynamic body, bool isFormData = false}) {
    return dio.put(endpoint, data: body);
  }

  @override
  Future<Response> patch(String endpoint,
      {dynamic body}) {
    return dio.patch(endpoint, data: body);
  }

  @override
  Future<Response> delete(String endpoint,
      {dynamic body}) {
    return dio.delete(endpoint, data: body);
  }
}