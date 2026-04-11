import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/orders/domain/repo/orders_repository.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';
import 'package:pharmacist/features/orders/presentation/widgets/orders_filter_tabs.dart';
import 'package:pharmacist/features/orders/presentation/widgets/orders_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersBloc(OrdersRepository(DioConsumer(Dio())))
        ..add(GetOnlineOrders(1)),
      child: const _OrdersScreenBody(),
    );
  }
}

class _OrdersScreenBody extends StatefulWidget {
  const _OrdersScreenBody();

  @override
  State<_OrdersScreenBody> createState() => _OrdersScreenBodyState();
}

class _OrdersScreenBodyState extends State<_OrdersScreenBody> {
  String _tab = OrdersList.deliveryTab;

  void _onTabChanged(String value) {
    if (_tab == value) return;
    setState(() => _tab = value);
    final bloc = context.read<OrdersBloc>();
    if (value == OrdersList.deliveryTab) {
      bloc.add(GetOnlineOrders(1));
    } else {
      bloc.add(GetPickupOrders(1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Orders',
        isDarkMode: isDark,
      ),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: Column(
          children: [
            const SizedBox(height: 16),
            OrdersFilterTabs(
              selected: _tab,
              onChanged: _onTabChanged,
            ),
            Expanded(
              child: OrdersList(filterType: _tab),
            ),
          ],
        ),
      ),
    );
  }
}
