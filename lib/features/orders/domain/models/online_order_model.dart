import 'package:pharmacist/core/date_time_extensions.dart';
import 'package:pharmacist/features/orders/domain/models/order_item_model.dart';

class OnlineOrderModel {
  final String orderId;
  final String clientName;
  final String clientPhone;
  final double totalPrice;
  final String status;
  final DateTime orderDate;
  final double distanceFromBranch;
  final String deliveryAddress;
  final String additionalInfo;
  final List<OrderItemModel> items;
  final bool isPaid;

  OnlineOrderModel({
    required this.orderId,
    required this.clientName,
    required this.clientPhone,
    required this.totalPrice,
    required this.status,
    required this.orderDate,
    required this.distanceFromBranch,
    required this.deliveryAddress,
    required this.additionalInfo,
    required this.items,
    required this.isPaid,
  });

  factory OnlineOrderModel.fromJson(Map<String, dynamic> json) {
    return OnlineOrderModel(
      orderId: json['orderId'],
      clientName: json['clientName'],
      clientPhone: json['clientPhone'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'],
      orderDate: parseUtcOrderDate(json['orderDate']as String),
      distanceFromBranch: (json['distanceFromBranch'] as num).toDouble(),
      deliveryAddress: json['deliveryAddress'],
      additionalInfo: json['additionalInfo'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      isPaid: json['is_paid'] as bool,
    );
  }
}
