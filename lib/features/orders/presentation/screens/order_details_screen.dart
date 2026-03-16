import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import '../widgets/order_product_item.dart';
import '../widgets/order_status_selector.dart';
import '../widgets/order_status_stepper.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: "Order Details",
        showBackButton: true,
        isDarkMode: isDark,
      ),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Client: Ahmed Mohamed",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            /// ORDER STATUS STEPPER
            const OrderStatusStepper(currentStatus: "Preparing"),

            const SizedBox(height: 20),

            /// PRODUCTS
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  OrderProductItem(),
                  OrderProductItem(),
                  OrderProductItem(),
                ],
              ),
            ),

            /// CHANGE STATUS
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: OrderStatusSelector(),
            ),

            const SizedBox(height: 12),

            const Text(
              "Total: \$320",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
