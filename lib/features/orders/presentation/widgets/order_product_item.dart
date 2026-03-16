import 'package:flutter/material.dart';

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/smartcare_logo.png",
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Panadol Extra",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 4),

                  Text("Quantity: 2"),

                  SizedBox(height: 4),

                  Text("Subtotal: \$40"),
                ],
              ),
            ),

            const Text("\$20", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
