import 'package:flutter/material.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_status_selector.dart';
import 'package:pharmacist/features/orders/presentation/widgets/total_bar.dart';

class OrderDetailsActionSection extends StatelessWidget {
  const OrderDetailsActionSection({
    super.key,
    required this.total,
    required this.orderId,
    required this.isOnlineOrder,
    required this.apiStatus,
    required this.onStatusUpdated,
  });

  final double total;
  final String orderId;
  final bool isOnlineOrder;
  final String apiStatus;
  final ValueChanged<String> onStatusUpdated;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalBar(total: total),
          const SizedBox(height: 12),
          OrderStatusSelector(
            orderId: orderId,
            isOnlineOrder: isOnlineOrder,
            apiStatus: apiStatus,
            onStatusUpdated: onStatusUpdated,
          ),
        ],
      ),
    );
  }
}
