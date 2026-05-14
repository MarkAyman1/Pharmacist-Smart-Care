import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacist/core/date_time_extensions.dart';
import 'package:pharmacist/features/orders/domain/models/online_order_model.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/delivery_payment_status_widget.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_client_hero_header.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_online_info_section.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_details_action_section.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_items_section.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/payment_status_widget.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_status_stepper.dart';

class OnlineOrderDetailsContent extends StatelessWidget {
  const OnlineOrderDetailsContent({
    super.key,
    required this.order,
    required this.dateFmt,
    required this.currentStatus,
    required this.onStatusUpdated,
  });

  final OnlineOrderModel order;
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
          orderDateLabel: dateFmt.format(order.orderDate.egyptTime),
        ),
        OrderStatusStepper(currentStatus: currentStatus, isOnlineOrder: true),
        PaymentStatusWidget(isPaid: order.isPaid, status: currentStatus),
        DeliveryPaymentStatusWidget(isPaid: order.isPaid, status: currentStatus),
        OrderOnlineInfoSection(order: order),
        OrderItemsSection(items: order.items),
        OrderDetailsActionSection(
          total: order.totalPrice,
          deliveryFee: order.deliveryFees,
          orderId: order.orderId,
          isOnlineOrder: true,
          apiStatus: currentStatus,
          onStatusUpdated: onStatusUpdated,
        ),
      ],
    );
  }
}
