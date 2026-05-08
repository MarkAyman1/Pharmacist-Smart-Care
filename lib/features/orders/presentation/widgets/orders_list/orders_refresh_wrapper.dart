import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_state.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';

import 'orders_list.dart';

class OrdersRefreshWrapper extends StatelessWidget {
  const OrdersRefreshWrapper({
    super.key,
    required this.filterType,
    required this.child,
  });

  final String filterType;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primaryblue,
      onRefresh: () async {
        final bloc = context.read<OrdersBloc>();

        if (filterType == OrdersList.deliveryTab) {
          bloc.add(GetOnlineOrders(1));
        } else {
          bloc.add(GetPickupOrders(1));
        }

        await bloc.stream.firstWhere(
          (s) =>
              s is OnlineOrdersLoaded ||
              s is PickupOrdersLoaded ||
              s is OrdersError,
        );
      },
      child: child,
    );
  }
}
