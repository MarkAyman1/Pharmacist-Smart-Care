class LoginResponseModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  Map<String, dynamic>? errorsBag;
  LoginData? data;

  LoginResponseModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    errorsBag = json['errorsBag'];
    // Check if 'data' is not null before parsing
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
}

class LoginData {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? accessTokenExpiresAt;
  String? refreshTokenExpiresAt;

  LoginData({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.accessTokenExpiresAt,
    this.refreshTokenExpiresAt,
  });

  LoginData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    tokenType = json['tokenType'];
    accessTokenExpiresAt = json['accessTokenExpiresAt'];
    refreshTokenExpiresAt =
        json['refreshTokenExpiresAt']; 
  }
}