import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacist/features/orders/domain/models/pickup_order_model.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_client_hero_header.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_details_action_section.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_items_section.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/payment_status_widget.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_status_stepper.dart';

class PickupOrderDetailsContent extends StatelessWidget {
  const PickupOrderDetailsContent({
    super.key,
    required this.order,
    required this.dateFmt,
    required this.currentStatus,
    required this.onStatusUpdated,
  });

  final PickupOrderModel order;
  final DateFormat dateFmt;
  final String currentStatus;
  final ValueChanged<String> onStatusUpdated;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        OrderClientHeroHeader(
          clientName: order.clientName,
          phone: order.clientPhone,
          status: currentStatus,
          orderId: order.orderId,
          orderDateLabel: dateFmt.format(order.orderDate.toLocal()),
        ),
        OrderStatusStepper(currentStatus: currentStatus, isOnlineOrder: false),
        PaymentStatusWidget(isPaid: order.isPaid, status: currentStatus),
        OrderItemsSection(items: order.items),
        OrderDetailsActionSection(
          total: order.totalPrice,
          orderId: order.orderId,
          isOnlineOrder: false,
          apiStatus: currentStatus,
          onStatusUpdated: onStatusUpdated,
        ),
      ],
    );
  }
}
