import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/categories/presentation/widgets/categories/categories_header.dart';
import 'package:pharmacist/features/categories/presentation/widgets/categories/categories_grid.dart';
import 'package:pharmacist/features/categories/domain/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categories = mockCategories;

    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Categories',
        showBackButton: false,
        isDarkMode: isDark,
      ),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoriesHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: CategoriesGrid(categories: categories),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}