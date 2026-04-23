abstract class OrdersEvent {}

class GetOnlineOrders extends OrdersEvent {
  final int page;
  final bool append;

  GetOnlineOrders(this.page, {this.append = false});
}

class GetPickupOrders extends OrdersEvent {
  final int page;
  final bool append;

  GetPickupOrders(this.page, {this.append = false});
}

class UpdateOrderStatus extends OrdersEvent {
  final String orderId;
  final int status;
  final bool isOnlineOrder;

  UpdateOrderStatus({
    required this.orderId,
    required this.status,
    required this.isOnlineOrder,
  });
}

class VerifyPickupCode extends OrdersEvent {
  final String orderId;
  final String code;

  VerifyPickupCode({required this.orderId, required this.code});
}
