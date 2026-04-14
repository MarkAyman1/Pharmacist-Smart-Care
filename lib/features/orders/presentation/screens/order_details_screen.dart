import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_state.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';
import 'package:pharmacist/features/orders/presentation/models/order_details_route_args.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_client_hero_header.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_online_info_section.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_details/order_pickup_code_section.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_product_item.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_status_selector.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_status_stepper.dart';

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
          child: switch (args) {
            OnlineOrderRouteArgs(:final order) => _OrderDetailsScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    OrderClientHeroHeader(
                      clientName: order.clientName,
                      phone: order.clientPhone,
                      status: order.status,
                      orderId: order.orderId,
                      orderDateLabel: dateFmt.format(order.orderDate.toLocal()),
                    ),
                    OrderStatusStepper(currentStatus: order.status),
                    OrderOnlineInfoSection(order: order),
                    const SizedBox(height: 8),
                    _SectionTitle(title: 'Items'),
                    ...order.items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: OrderProductItem(item: item),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _TotalBar(total: order.totalPrice),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: OrderStatusSelector(
                        orderId: order.orderId,
                        isOnlineOrder: true,
                        apiStatus: order.status,
                      ),
                    ),
                  ],
                ),
              ),
            PickupOrderRouteArgs(:final order) => _OrderDetailsScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    OrderClientHeroHeader(
                      clientName: order.clientName,
                      phone: order.clientPhone,
                      status: order.status,
                      orderId: order.orderId,
                      orderDateLabel: dateFmt.format(order.orderDate.toLocal()),
                    ),
                    OrderStatusStepper(currentStatus: order.status),
                    OrderPickupCodeSection(code: order.pickupCode),
                    const SizedBox(height: 8),
                    _SectionTitle(title: 'Items'),
                    ...order.items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: OrderProductItem(item: item),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _TotalBar(total: order.totalPrice),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: OrderStatusSelector(
                        orderId: order.orderId,
                        isOnlineOrder: false,
                        apiStatus: order.status,
                      ),
                    ),
                  ],
                ),
              ),
          },
        ),
      ),
    );
  }
}

class _OrderDetailsScrollView extends StatelessWidget {
  const _OrderDetailsScrollView({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _TotalBar extends StatelessWidget {
  const _TotalBar({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? Theme.of(context).cardColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order total',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
