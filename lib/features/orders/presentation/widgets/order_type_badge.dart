import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class OrderTypeBadge extends StatelessWidget {
  final String type;

  const OrderTypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    IconData icon = type == "Delivery"
        ? Icons.local_shipping_rounded
        : Icons.storefront;

    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryblue),
        const SizedBox(width: 6),
        Text(type),
      ],
    );
  }
}
