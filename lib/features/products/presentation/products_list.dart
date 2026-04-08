import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/products/model/product_model.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_event.dart';
import 'package:pharmacist/features/products/presentation/product_card.dart';
import 'package:pharmacist/features/products/presentation/quantity_dialog.dart';

class ProductsList extends StatelessWidget {
  final List<ProductModel> products;
  final bool hasNext;
  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const ProductsList({
    super.key,
    required this.products,
    required this.hasNext,
    required this.currentPage,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final product = products[index];

              return ProductCard(
                nameEn: product.nameEn,
                nameAr: product.nameAr,
                description: product.description,
                imageUrl: product.primaryImageUrl,
                price: product.price,
                discount: product.discountPercentage,
                rating: product.averageRating,
                quantity: product.availableStock,
                isAvailable: product.isAvailable,
                dosageForm: product.dosageForm,
                onIncrease: () async {
                  final value = await showQuantityDialog(
                    context,
                    isIncrease: true,
                    currentQuantity: product.availableStock,
                  );

                  if (value != null && value > 0) {
                    context.read<CategoriesBloc>().add(
                      IncreaseStockEvent(
                        productId: product.productId,
                        quantity: value,
                      ),
                    );
                  }
                },

                onDecrease: () async {
                  final value = await showQuantityDialog(
                    context,
                    isIncrease: false,
                    currentQuantity: product.availableStock,
                  );

                  if (value != null && value > 0) {
                    context.read<CategoriesBloc>().add(
                      DecreaseStockEvent(
                        productId: product.productId,
                        quantity: value,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),

        /// Pagination Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: currentPage > 1 ? onPrevious : null,
              child: const Text("Previous"),
            ),
            Text("Page $currentPage"),
            ElevatedButton(
              onPressed: hasNext ? onNext : null,
              child: const Text("Next"),
            ),
          ],
        ),
      ],
    );
  }
}
