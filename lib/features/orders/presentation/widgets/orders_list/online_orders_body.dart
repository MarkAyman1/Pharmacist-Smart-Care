import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacist/core/date_time_extensions.dart';

import 'package:pharmacist/features/orders/domain/models/online_order_model.dart';
import 'package:pharmacist/features/orders/domain/models/paginated_orders.dart';

import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';

import 'package:pharmacist/features/orders/presentation/models/order_details_route_args.dart';

import 'package:pharmacist/features/orders/presentation/screens/order_details_screen.dart';

import 'package:pharmacist/features/orders/presentation/widgets/order_card.dart';

import 'load_more_tile.dart';
import 'orders_list.dart';

class OnlineOrdersBody extends StatelessWidget {
  const OnlineOrdersBody({super.key, required this.data});

  final PaginatedOrders<OnlineOrderModel> data;

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.MMMd().add_jm();

    if (data.items.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 120),
          Column(
            children: [
              SizedBox(
                height: 220,
                child: Lottie.asset(
                  'assets/animations/Not Found.json',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 12),

              const Center(child: Text('No delivery orders for today')),
            ],
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      itemCount: data.items.length + (data.hasNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == data.items.length) {
          return LoadMoreTile(
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
            orderDateLabel: dateFmt.format(order.orderDate.egyptTime),
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
