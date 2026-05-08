import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmacist/core/app_color.dart';

import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';

import 'orders_list.dart';

class OrdersErrorView extends StatelessWidget {
  const OrdersErrorView({
    super.key,
    required this.message,
    required this.filterType,
  });

  final String message;
  final String filterType;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(32),
      children: [
        const SizedBox(height: 48),

        Icon(
          Icons.cloud_off_rounded,
          size: 56,
          color: AppColors.mediumGrey,
        ),

        const SizedBox(height: 16),

        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        const SizedBox(height: 24),

        Center(
          child: FilledButton(
            onPressed: () {
              final bloc = context.read<OrdersBloc>();

              if (filterType == OrdersList.deliveryTab) {
                bloc.add(GetOnlineOrders(1));
              } else {
                bloc.add(GetPickupOrders(1));
              }
            },
            child: const Text('Try again'),
          ),
        ),
      ],
    );
  }
}