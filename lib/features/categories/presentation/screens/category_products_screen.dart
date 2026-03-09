import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/categories/presentation/widgets/products/products_list.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;
  final List products;

  const CategoryProductsScreen({
    super.key,
    required this.categoryName,
    required this.products,
  });

  @override
  State<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: widget.categoryName,
        showBackButton: true,
        isDarkMode: isDark,
      ),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ProductsList(
              products: widget.products,
              onIncrease: (index, value) {
                setState(() {
                  widget.products[index].quantity += value;
                });
              },
              onDecrease: (index, value) {
                setState(() {
                  widget.products[index].quantity =
                      (widget.products[index].quantity - value)
                          .clamp(0, 1 << 31);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}