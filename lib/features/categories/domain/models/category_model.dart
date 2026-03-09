import 'package:pharmacist/features/companies/domain/models/company_model.dart';

class Category {
  final String name;
  final String imageUrl;
  final List<Product> products;

  Category({
    required this.name,
    required this.imageUrl,
    required this.products,
  });
}

final List<Category> mockCategories = [
  Category(
    name: 'Pain Relief',
    imageUrl: '',
    products: [
      Product(
        name: 'Ibuprofen 400mg',
        imageUrl: '',
        price: 30,
        quantity: 15,
      ),
      Product(
        name: 'Paracetamol 500mg',
        imageUrl: '',
        price: 25,
        quantity: 20,
      ),
    ],
  ),
  Category(
    name: 'Vitamins',
    imageUrl: '',
    products: [
      Product(
        name: 'Vitamin D 5000 IU',
        imageUrl: '',
        price: 75,
        quantity: 10,
      ),
      Product(
        name: 'Multivitamin Tablets',
        imageUrl: '',
        price: 95,
        quantity: 7,
      ),
    ],
  ),
  Category(
    name: 'Digestive Health',
    imageUrl: '',
    products: [
      Product(
        name: 'Probiotic Capsules',
        imageUrl: '',
        price: 85,
        quantity: 5,
      ),
      Product(
        name: 'Antacid Suspension',
        imageUrl: '',
        price: 40,
        quantity: 9,
      ),
    ],
  ),
  Category(
    name: 'Allergy',
    imageUrl: '',
    products: [
      Product(
        name: 'Antihistamine Tablets',
        imageUrl: '',
        price: 65,
        quantity: 6,
      ),
      Product(
        name: 'Nasal Spray',
        imageUrl: '',
        price: 55,
        quantity: 4,
      ),
    ],
  ),
];