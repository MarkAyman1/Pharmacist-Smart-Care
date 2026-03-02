class RegisterResponseModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  Map<String, dynamic>? errorsBag;
  bool? data;

  RegisterResponseModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    errorsBag = json['errorsBag'];
    data = json['data'];
  }
}