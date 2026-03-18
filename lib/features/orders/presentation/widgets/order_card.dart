import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';
import 'order_status_badge.dart';
import 'order_type_badge.dart';

class OrderCard extends StatelessWidget {
  final String clientName;
  final String status;
  final String type;
  final double totalPrice;
  final int itemsCount;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.clientName,
    required this.status,
    required this.type,
    required this.totalPrice,
    required this.itemsCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// CLIENT + STATUS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    clientName,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  OrderStatusBadge(status: status),
                ],
              ),

              const SizedBox(height: 10),

              /// TYPE + ITEMS
              Row(
                children: [
                  OrderTypeBadge(type: type),
                  const SizedBox(width: 12),
                  Text("$itemsCount items", style: theme.textTheme.bodyMedium),
                ],
              ),

              const SizedBox(height: 16),

              /// TOTAL PRICE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: theme.textTheme.bodyMedium),
                  Row(
                    children: [
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
