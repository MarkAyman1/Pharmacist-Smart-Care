import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/companies/domain/models/company_model.dart';
import 'package:pharmacist/features/companies/presentation/widgets/products/products_list.dart';

class CompanyProductsScreen extends StatefulWidget {
  final String companyName;
  final List<Product> products;

  const CompanyProductsScreen({super.key, required this.companyName, required this.products});

  @override
  State<CompanyProductsScreen> createState() => _CompanyProductsScreenState();
}

class _CompanyProductsScreenState extends State<CompanyProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(title: widget.companyName, showBackButton: true, isDarkMode: isDark),
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
                  widget.products[index].quantity = (widget.products[index].quantity - value).clamp(0, 1 << 31);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}