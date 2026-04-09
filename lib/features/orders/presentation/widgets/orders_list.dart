import 'package:flutter/material.dart';
import '../screens/order_details_screen.dart';
import 'order_card.dart';

class OrdersList extends StatelessWidget {
  final String filterType;

  const OrdersList({super.key, required this.filterType});

  @override
  Widget build(BuildContext context) {
    /// fake data
    final allOrders = List.generate(
      10,
      (index) => {
        "client": "Ahmed Mohamed",
        "status": "Preparing",
        "type": index % 2 == 0 ? "Delivery" : "Pickup",
        "price": 320.0,
        "items": 3,
      },
    );

    final filteredOrders =
        allOrders.where((e) => e["type"] == filterType).toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];

        return OrderCard(
          clientName: order["client"] as String,
          status: order["status"] as String,
          type: order["type"] as String,
          totalPrice: order["price"] as double,
          itemsCount: order["items"] as int,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const OrderDetailsScreen(),
              ),
            );
          },
        );
      },
    );
  }
}