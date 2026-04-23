import 'package:flutter/material.dart';
import 'package:pharmacist/features/orders/domain/models/order_item_model.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_product_item.dart';
import 'package:pharmacist/features/orders/presentation/widgets/section_title.dart';

class OrderItemsSection extends StatelessWidget {
  const OrderItemsSection({super.key, required this.items});

  final List<OrderItemModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        const SectionTitle(title: 'Items'),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OrderProductItem(item: item),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
