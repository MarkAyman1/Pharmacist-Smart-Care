import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_state.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';

import 'online_orders_body.dart';
import 'orders_error_view.dart';
import 'orders_refresh_wrapper.dart';
import 'pickup_orders_body.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key, required this.filterType});

  static const String deliveryTab = 'Delivery';
  static const String pickupTab = 'Pickup';

  final String filterType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrdersError) {
          return OrdersErrorView(
            message: state.message,
            filterType: filterType,
          );
        }

        if (filterType == deliveryTab) {
          if (state is OnlineOrdersLoaded) {
            return OrdersRefreshWrapper(
              filterType: filterType,
              child: OnlineOrdersBody(data: state.data),
            );
          }
        } else {
          if (state is PickupOrdersLoaded) {
            return OrdersRefreshWrapper(
              filterType: filterType,
              child: PickupOrdersBody(data: state.data),
            );
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
