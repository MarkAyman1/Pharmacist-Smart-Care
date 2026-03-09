import 'package:flutter/material.dart';

Future<int?> showQuantityDialog(
  BuildContext context, {
  required bool isIncrease,
  required int currentQuantity,
}) async {
  final controller = TextEditingController(text: '1');

  return showDialog<int>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(isIncrease ? 'Increase quantity' : 'Decrease quantity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current quantity: $currentQuantity'),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              Navigator.pop(context, value);
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}