class ApiResponse<T> {
  final int statusCode;
  final bool succeeded;
  final String message;
  final Map<String, dynamic>? errorsBag;
  final T? data;

  ApiResponse({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    this.errorsBag,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ApiResponse<T>(
      statusCode: json['statusCode'] as int,
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      errorsBag: json['errorsBag'] as Map<String, dynamic>?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
