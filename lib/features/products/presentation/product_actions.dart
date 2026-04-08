import 'package:flutter/material.dart';

class ProductActions extends StatelessWidget {
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const ProductActions({
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _circle(Icons.add, Colors.green, onIncrease),
        const SizedBox(height: 8),
        _circle(Icons.remove, Colors.red, onDecrease),
      ],
    );
  }

  Widget _circle(IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: color.withValues(alpha: 0.15),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}