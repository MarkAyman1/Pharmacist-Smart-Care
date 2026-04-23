import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_state.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';
import 'package:pharmacist/features/orders/presentation/models/order_details_route_args.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_details_body.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.args});

  final OrderDetailsRouteArgs args;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFmt = DateFormat.yMMMd().add_jm();

    return BlocListener<OrdersBloc, OrdersState>(
      listenWhen: (previous, current) => current is OrderStatusUpdated,
      listener: (context, state) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order status updated'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Future<void>.delayed(const Duration(milliseconds: 400), () {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        });
      },
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: 'Order details',
          showBackButton: true,
          isDarkMode: isDark,
        ),
        body: Container(
          decoration: AppBackground.decoration(isDark: isDark),
          child: OrderDetailsBody(args: args, dateFmt: dateFmt),
        ),
      ),
    );
  }
}
