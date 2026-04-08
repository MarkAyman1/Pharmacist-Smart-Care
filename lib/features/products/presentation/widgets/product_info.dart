import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final String nameEn;
  final String nameAr;
  final String description;
  final double price;
  final double finalPrice;
  final double discount;
  final double rating;
  final int quantity;
  final bool isAvailable;
  final String dosageForm;

  const ProductInfo({
    required this.nameEn,
    required this.nameAr,
    required this.description,
    required this.price,
    required this.finalPrice,
    required this.discount,
    required this.rating,
    required this.quantity,
    required this.isAvailable,
    required this.dosageForm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nameEn, style: theme.textTheme.bodyLarge),

        const SizedBox(height: 4),

        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall,
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            Text(
              'EGP ${finalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (discount > 0)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  'EGP ${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 4),

        Row(
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber),
            Text(rating.toString()),
            const SizedBox(width: 8),
            Text(dosageForm),
          ],
        ),

        const SizedBox(height: 4),

        Text(
          isAvailable ? "Available" : "Out of stock",
          style: TextStyle(color: isAvailable ? Colors.green : Colors.red),
        ),

        Text("Stock: $quantity"),
      ],
    );
  }
}
