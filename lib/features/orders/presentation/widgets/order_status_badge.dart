import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;

  const OrderStatusBadge({super.key, required this.status});

  Color _color() {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return AppColors.primaryblue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color().withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: _color(), fontWeight: FontWeight.bold),
      ),
    );
  }
}
