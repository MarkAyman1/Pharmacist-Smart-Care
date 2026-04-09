import 'package:flutter/material.dart';
import 'package:pharmacist/features/products/domain/model/product_model.dart';
import 'package:pharmacist/features/products/presentation/widgets/products_list.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<ProductModel> products;

  const SearchResultsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text("No products found 😢"));
    }

    return ProductsList(products: products, hasNext: false, currentPage: 1);
  }
}
