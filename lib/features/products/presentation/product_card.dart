import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/products/presentation/product_actions.dart';
import 'package:pharmacist/features/products/presentation/product_image.dart';
import 'package:pharmacist/features/products/presentation/product_info.dart';

class ProductCard extends StatelessWidget {
  final String nameEn;
  final String nameAr;
  final String description;
  final String imageUrl;
  final double price;
  final double discount;
  final double rating;
  final int quantity;
  final bool isAvailable;
  final String dosageForm;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const ProductCard({
    super.key,
    required this.nameEn,
    required this.nameAr,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.discount,
    required this.rating,
    required this.quantity,
    required this.isAvailable,
    required this.dosageForm,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final finalPrice = price - (price * discount / 100);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ProductImage(imageUrl: imageUrl),
          const SizedBox(width: 12),
          Expanded(
            child: ProductInfo(
              nameEn: nameEn,
              nameAr: nameAr,
              description: description,
              price: price,
              finalPrice: finalPrice,
              discount: discount,
              rating: rating,
              quantity: quantity,
              isAvailable: isAvailable,
              dosageForm: dosageForm,
            ),
          ),
          ProductActions(
            onIncrease: onIncrease,
            onDecrease: onDecrease,
          ),
        ],
      ),
    );
  }
}