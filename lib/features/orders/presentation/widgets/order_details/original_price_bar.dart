import 'package:flutter/material.dart';

class OriginalPriceBar extends StatelessWidget {
  const OriginalPriceBar({
    super.key,
    required this.total,
    required this.deliveryFee,
  });

  final double total;
  final double deliveryFee;

  double get originalPrice => total - deliveryFee;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isDark
              ? theme.colorScheme.surface
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.green.withValues(alpha: 0.18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                color: Colors.green,
                size: 24,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Original Price',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Before delivery fees',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'EGP ${originalPrice.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}