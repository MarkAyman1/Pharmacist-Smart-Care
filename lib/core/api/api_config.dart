class ApiConfig {
  static const String baseUrl =
      String.fromEnvironment('BASE_URL', defaultValue: 'https://smartcarepharmacy.tryasp.net/');

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}