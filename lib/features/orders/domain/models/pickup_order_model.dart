import 'package:pharmacist/core/date_time_extensions.dart';
import 'package:pharmacist/features/orders/domain/models/order_item_model.dart';

class PickupOrderModel {
  final String orderId;
  final String clientName;
  final String clientPhone;
  final double totalPrice;
  final String status;
  final DateTime orderDate;
  final String pickupCode;
  final List<OrderItemModel> items;
  final bool isPaid;

  PickupOrderModel({
    required this.orderId,
    required this.clientName,
    required this.clientPhone,
    required this.totalPrice,
    required this.status,
    required this.orderDate,
    required this.pickupCode,
    required this.items,
    required this.isPaid,
  });

  factory PickupOrderModel.fromJson(Map<String, dynamic> json) {
    return PickupOrderModel(
      orderId: json['orderId'],
      clientName: json['clientName'],
      clientPhone: json['clientPhone'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'],
      orderDate: parseUtcOrderDate(json['orderDate']as String),
      pickupCode: json['pickupCode'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      isPaid: json['is_paid'] as bool,
    );
  }
}
