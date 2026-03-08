import 'package:flutter/material.dart';
import 'package:pharmacist/features/categories/presentation/screens/category_products_screen.dart';
import 'package:pharmacist/features/categories/presentation/widgets/category_card.dart';

class CategoriesGrid extends StatelessWidget {
  final List categories;

  const CategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return CategoryCard(
          name: category.name,
          imageUrl: category.imageUrl,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CategoryProductsScreen(
                  categoryName: category.name,
                  products: category.products,
                ),
              ),
            );
          },
        );
      },
    );
  }
}