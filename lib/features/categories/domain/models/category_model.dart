class CategoryModel {
  final String id;
  final String name;
  final int productsCount;
  final String logoUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.logoUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      productsCount: json['productsCount'] ?? 0,
      logoUrl: json['logoUrl'] ?? '',
    );
  }
}