import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacist/features/orders/presentation/models/order_details_route_args.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details_scroll_view.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/online_order_details_content.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/pickup_order_details_content.dart';

class OrderDetailsBody extends StatefulWidget {
  const OrderDetailsBody({
    super.key,
    required this.args,
    required this.dateFmt,
  });

  final OrderDetailsRouteArgs args;
  final DateFormat dateFmt;

  @override
  State<OrderDetailsBody> createState() => _OrderDetailsBodyState();
}

class _OrderDetailsBodyState extends State<OrderDetailsBody> {
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = switch (widget.args) {
      OnlineOrderRouteArgs(:final order) => order.status,
      PickupOrderRouteArgs(:final order) => order.status,
    };
  }

  void _handleStatusUpdated(String status) {
    setState(() {
      _currentStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.args) {
      OnlineOrderRouteArgs(:final order) => OrderDetailsScrollView(
        child: OnlineOrderDetailsContent(
          order: order,
          dateFmt: widget.dateFmt,
          currentStatus: _currentStatus,
          onStatusUpdated: _handleStatusUpdated,
        ),
      ),
      PickupOrderRouteArgs(:final order) => OrderDetailsScrollView(
        child: PickupOrderDetailsContent(
          order: order,
          dateFmt: widget.dateFmt,
          currentStatus: _currentStatus,
          onStatusUpdated: _handleStatusUpdated,
        ),
      ),
    };
  }
}
