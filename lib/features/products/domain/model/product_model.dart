class ProductModel {
  final String productId;
  final String nameEn;
  final String nameAr;
  final String description;
  final double price;
  final double discountPercentage;
  final double averageRating;
  final bool isAvailable;
  final String dosageForm;
  final int stockQuantity;
  final int availableStock;
  final List<String> imageUrls;
  final String primaryImageUrl;

  ProductModel({
    required this.productId,
    required this.nameEn,
    required this.nameAr,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.averageRating,
    required this.isAvailable,
    required this.dosageForm,
    required this.stockQuantity,
    required this.availableStock,
    required this.imageUrls,
    required this.primaryImageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
    productId: json['productId'] ?? '',
    nameEn: json['nameEn'] ?? '',
    nameAr: json['nameAr'] ?? '',
    description: json['description'] ?? '',

    price: (json['price'] ?? 0).toDouble(),
    discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
    averageRating: (json['averageRating'] ?? 0).toDouble(),

    isAvailable: json['isAvailable'] ?? false,
    dosageForm: json['dosageForm'] ?? '',

    stockQuantity: json['stockQuantity'] ?? 0,
    availableStock: json['availableStock'] ?? 0,

    imageUrls: json['imageUrls'] != null
        ? List<String>.from(json['imageUrls'])
        : [],

    primaryImageUrl: json['primaryImageUrl'] ?? '',
  );
}
}
