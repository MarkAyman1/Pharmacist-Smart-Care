class Product {
  final String name;
  final String imageUrl;
  final double price;
  int quantity;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 0,
  });
}

class Company {
  final String name;
  final String imageUrl;
  final List<Product> products;

  Company({
    required this.name,
    required this.imageUrl,
    required this.products,
  });
}

final List<Company> mockCompanies = [
  Company(
    name: 'PharmaCare',
    imageUrl: '',
    products: [
      Product(name: 'Pain Relief Tablets', imageUrl: '', price: 45.0, quantity: 10),
      Product(name: 'Vitamin C 1000mg', imageUrl: '', price: 60.0, quantity: 5),
    ],
  ),
  Company(
    name: 'HealthPlus',
    imageUrl: '',
    products: [
      Product(name: 'Antibiotic Syrup', imageUrl: '', price: 80.0, quantity: 3),
      Product(name: 'Allergy Capsules', imageUrl: '', price: 55.0, quantity: 6),
    ],
  ),
  Company(
    name: 'MediLife',
    imageUrl: '',
    products: [
      Product(name: 'Cough Syrup', imageUrl: '', price: 35.0, quantity: 12),
      Product(name: 'Digestive Enzymes', imageUrl: '', price: 70.0, quantity: 4),
    ],
  ),
  Company(
    name: 'BioPharm',
    imageUrl: '',
    products: [
      Product(name: 'Multivitamin Gummies', imageUrl: '', price: 90.0, quantity: 8),
      Product(name: 'Omega 3 Capsules', imageUrl: '', price: 110.0, quantity: 2),
    ],
  ),
];