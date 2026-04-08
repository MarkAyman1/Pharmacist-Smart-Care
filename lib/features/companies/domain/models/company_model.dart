class CompanyModel {
  final String id;
  final String name;
  final int productsCount;
  final String logoUrl;

  CompanyModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.logoUrl,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      productsCount: json['productsCount'] ?? 0,
      logoUrl: json['logoUrl'] ?? '',
    );
  }
}