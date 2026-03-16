import 'package:flutter/material.dart';

class OrderStatusSelector extends StatefulWidget {
  const OrderStatusSelector({super.key});

  @override
  State<OrderStatusSelector> createState() => _OrderStatusSelectorState();
}

class _OrderStatusSelectorState extends State<OrderStatusSelector> {
  String status = "Pending";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: status,
      items: const [
        DropdownMenuItem(value: "Pending", child: Text("Pending")),
        DropdownMenuItem(value: "Preparing", child: Text("Preparing")),
        DropdownMenuItem(value: "Completed", child: Text("Completed")),
        DropdownMenuItem(value: "Cancelled", child: Text("Cancelled")),
      ],
      onChanged: (value) {
        setState(() {
          status = value!;
        });
      },
    );
  }
}
