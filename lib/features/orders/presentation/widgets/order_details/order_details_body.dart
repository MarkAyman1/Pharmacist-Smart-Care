import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacist/features/orders/presentation/models/order_details_route_args.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details_scroll_view.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/online_order_details_content.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/pickup_order_details_content.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({
    super.key,
    required this.args,
    required this.dateFmt,
  });

  final OrderDetailsRouteArgs args;
  final DateFormat dateFmt;

  @override
  Widget build(BuildContext context) {
    return switch (args) {
      OnlineOrderRouteArgs(:final order) => OrderDetailsScrollView(
        child: OnlineOrderDetailsContent(order: order, dateFmt: dateFmt),
      ),
      PickupOrderRouteArgs(:final order) => OrderDetailsScrollView(
        child: PickupOrderDetailsContent(order: order, dateFmt: dateFmt),
      ),
    };
  }
}
