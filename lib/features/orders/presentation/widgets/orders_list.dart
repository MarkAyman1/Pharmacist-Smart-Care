import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/domain/models/online_order_model.dart';
import 'package:pharmacist/features/orders/domain/models/paginated_orders.dart';
import 'package:pharmacist/features/orders/domain/models/pickup_order_model.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_state.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';
import 'package:pharmacist/features/orders/presentation/models/order_details_route_args.dart';
import 'package:pharmacist/features/orders/presentation/screens/order_details_screen.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_card.dart';

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
          return _OrdersErrorView(
            message: state.message,
            filterType: filterType,
          );
        }

        if (filterType == deliveryTab) {
          if (state is OnlineOrdersLoaded) {
            return _OrdersRefreshWrapper(
              filterType: filterType,
              child: _OnlineOrdersBody(data: state.data),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PickupOrdersLoaded) {
          return _OrdersRefreshWrapper(
            filterType: filterType,
            child: _PickupOrdersBody(data: state.data),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _OrdersRefreshWrapper extends StatelessWidget {
  const _OrdersRefreshWrapper({required this.filterType, required this.child});

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

class _OnlineOrdersBody extends StatelessWidget {
  const _OnlineOrdersBody({required this.data});

  final PaginatedOrders<OnlineOrderModel> data;

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.MMMd().add_jm();
    if (data.items.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 120),
          Center(child: Text('No delivery orders for today')),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      itemCount: data.items.length + (data.hasNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == data.items.length) {
          return _LoadMoreTile(
            label: 'Load more delivery orders',
            onPressed: () {
              context.read<OrdersBloc>().add(
                GetOnlineOrders(data.pageNumber + 1, append: true),
              );
            },
          );
        }
        final order = data.items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OrderCard(
            clientName: order.clientName,
            status: order.status,
            type: OrdersList.deliveryTab,
            totalPrice: order.totalPrice,
            itemsCount: order.items.length,
            subtitle: order.clientPhone,
            orderDateLabel: dateFmt.format(order.orderDate.toLocal()),
            onTap: () {
              final bloc = context.read<OrdersBloc>();
              Navigator.of(context)
                  .push(
                    MaterialPageRoute<void>(
                      builder: (_) => BlocProvider.value(
                        value: bloc,
                        child: OrderDetailsScreen(
                          args: OnlineOrderRouteArgs(order),
                        ),
                      ),
                    ),
                  )
                  .then((_) {
                    bloc.add(GetOnlineOrders(1));
                  });
            },
          ),
        );
      },
    );
  }
}

class _PickupOrdersBody extends StatelessWidget {
  const _PickupOrdersBody({required this.data});

  final PaginatedOrders<PickupOrderModel> data;

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.MMMd().add_jm();
    if (data.items.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 120),
          Center(child: Text('No pickup orders for today')),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      itemCount: data.items.length + (data.hasNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == data.items.length) {
          return _LoadMoreTile(
            label: 'Load more pickup orders',
            onPressed: () {
              context.read<OrdersBloc>().add(
                GetPickupOrders(data.pageNumber + 1, append: true),
              );
            },
          );
        }
        final order = data.items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OrderCard(
            clientName: order.clientName,
            status: order.status,
            type: OrdersList.pickupTab,
            totalPrice: order.totalPrice,
            itemsCount: order.items.length,
            subtitle: order.clientPhone,
            orderDateLabel: dateFmt.format(order.orderDate.toLocal()),
            onTap: () {
              final bloc = context.read<OrdersBloc>();
              Navigator.of(context)
                  .push(
                    MaterialPageRoute<void>(
                      builder: (_) => BlocProvider.value(
                        value: bloc,
                        child: OrderDetailsScreen(
                          args: PickupOrderRouteArgs(order),
                        ),
                      ),
                    ),
                  )
                  .then((_) {
                    bloc.add(GetPickupOrders(1));
                  });
            },
          ),
        );
      },
    );
  }
}

class _LoadMoreTile extends StatelessWidget {
  const _LoadMoreTile({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Center(
        child: FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

class _OrdersErrorView extends StatelessWidget {
  const _OrdersErrorView({required this.message, required this.filterType});

  final String message;
  final String filterType;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(32),
      children: [
        const SizedBox(height: 48),
        Icon(Icons.cloud_off_rounded, size: 56, color: AppColors.mediumGrey),
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
