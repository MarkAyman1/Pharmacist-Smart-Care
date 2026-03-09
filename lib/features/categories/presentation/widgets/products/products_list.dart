import 'package:flutter/material.dart';
import 'package:pharmacist/core/widgets/product_card.dart';
import 'package:pharmacist/features/categories/presentation/widgets/products/quantity_dialog.dart';

class ProductsList extends StatelessWidget {
  final List products;
  final Function(int index, int value) onIncrease;
  final Function(int index, int value) onDecrease;

  const ProductsList({
    super.key,
    required this.products,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.price,
          quantity: product.quantity,
          onIncrease: () async {
            final value = await showQuantityDialog(
              context,
              isIncrease: true,
              currentQuantity: product.quantity,
            );

            if (value != null) {
              onIncrease(index, value);
            }
          },
          onDecrease: () async {
            final value = await showQuantityDialog(
              context,
              isIncrease: false,
              currentQuantity: product.quantity,
            );

            if (value != null) {
              onDecrease(index, value);
            }
          },
        );
      },
    );
  }
}