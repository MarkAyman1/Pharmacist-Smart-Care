import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import '../widgets/orders_filter_tabs.dart';
import '../widgets/orders_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String selectedType = "Delivery";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: "Orders",
        isDarkMode: isDark,
      ),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// 🔥 FILTER TABS
            OrdersFilterTabs(
              selected: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),

            /// 🔥 LIST
            Expanded(
              child: OrdersList(filterType: selectedType),
            ),
          ],
        ),
      ),
    );
  }
}