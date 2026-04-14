import 'package:flutter/material.dart';
import 'package:pharmacist/features/orders/presentation/utils/order_status_mapper.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final code = OrderStatusMapper.codeFromApiStatus(status);
    final color = OrderStatusMapper.accentColorForStatusCode(code);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
