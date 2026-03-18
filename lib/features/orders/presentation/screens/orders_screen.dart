import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/orders/presentation/screens/order_details_screen.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(title: "Orders", isDarkMode: isDark),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          itemCount: 10,
          itemBuilder: (context, index) {
            return OrderCard(
              clientName: "Ahmed Mohamed",
              status: "Preparing",
              type: "Delivery",
              totalPrice: 320,
              itemsCount: 3,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailsScreen(),));
              },
            );
          },
        ),
      ),
    );
  }
}
