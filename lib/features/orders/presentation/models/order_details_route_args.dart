import 'package:pharmacist/features/orders/domain/models/online_order_model.dart';
import 'package:pharmacist/features/orders/domain/models/pickup_order_model.dart';

sealed class OrderDetailsRouteArgs {}

final class OnlineOrderRouteArgs extends OrderDetailsRouteArgs {
  OnlineOrderRouteArgs(this.order);
  final OnlineOrderModel order;
}

final class PickupOrderRouteArgs extends OrderDetailsRouteArgs {
  PickupOrderRouteArgs(this.order);
  final PickupOrderModel order;
}
