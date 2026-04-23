import 'package:pharmacist/features/orders/domain/models/online_order_model.dart';
import 'package:pharmacist/features/orders/domain/models/paginated_orders.dart';
import 'package:pharmacist/features/orders/domain/models/pickup_order_model.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}

// ONLINE
class OnlineOrdersLoaded extends OrdersState {
  final PaginatedOrders<OnlineOrderModel> data;
  OnlineOrdersLoaded(this.data);
}

// PICKUP
class PickupOrdersLoaded extends OrdersState {
  final PaginatedOrders<PickupOrderModel> data;
  PickupOrdersLoaded(this.data);
}

// UPDATE
class OrderStatusUpdated extends OrdersState {}

//verify pickup code
class VerifyPickupCodeLoading extends OrdersState {}

class VerifyPickupCodeSuccess extends OrdersState {
  final String message;
  VerifyPickupCodeSuccess(this.message);
}

class VerifyPickupCodeError extends OrdersState {
  final String message;
  VerifyPickupCodeError(this.message);
}
