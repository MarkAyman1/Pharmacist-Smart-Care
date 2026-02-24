import 'package:dio/dio.dart';
import 'package:pharmacist/core/services/cache_helper.dart';


class ApiInterceptor extends Interceptor {
  final Dio dio;

  ApiInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Accept'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = CacheHelper.getRefreshToken();
        final accessToken = CacheHelper.getAccessToken();

        if (refreshToken == null) {
          return handler.next(err);
        }

        final response = await dio.post(
          '/api/auth/refresh-token',
          data: {
            "accessToken": accessToken,
            "refreshToken": refreshToken,
          },
        );

        final newAccess = response.data['data']['accessToken'];
        final newRefresh = response.data['data']['refreshToken'];

        await CacheHelper.saveAccessToken(newAccess);
        await CacheHelper.saveRefreshToken(newRefresh);

        final retryResponse = await _retry(err.requestOptions, newAccess);

        return handler.resolve(retryResponse);
      } catch (_) {
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  Future<Response> _retry(
      RequestOptions requestOptions, String newToken) {
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          'Authorization': 'Bearer $newToken',
        },
      ),
    );
  }
}