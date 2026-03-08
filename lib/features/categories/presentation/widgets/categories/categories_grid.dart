import 'package:flutter/material.dart';
import 'package:pharmacist/features/categories/presentation/screens/category_products_screen.dart';
import 'package:pharmacist/features/categories/presentation/widgets/category_card.dart';

class CategoriesGrid extends StatelessWidget {
  final List categories;

  const CategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int crossAxisCount;
        if (width >= 1200) {
          crossAxisCount = 5;
        } else if (width >= 900) {
          crossAxisCount = 4; 
        } else if (width >= 600) {
          crossAxisCount = 3; 
        } else {
          crossAxisCount = 2; 
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
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
      },
    );
  }
}