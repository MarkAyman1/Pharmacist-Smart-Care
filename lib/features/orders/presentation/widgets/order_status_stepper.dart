import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class OrderStatusStepper extends StatelessWidget {
  final String currentStatus;

  const OrderStatusStepper({super.key, required this.currentStatus});

  int _index() {
    switch (currentStatus) {
      case "Pending":
        return 0;
      case "Preparing":
        return 1;
      case "Out for delivery":
        return 2;
      case "Completed":
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = ["Pending", "Preparing", "Delivery", "Completed"];

    final currentIndex = _index();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(steps.length, (index) {
          final active = index <= currentIndex;

          return Expanded(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? AppColors.primaryblue
                        : Colors.grey.shade300,
                  ),
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                ),

                const SizedBox(height: 6),

                Text(
                  steps[index],
                  style: TextStyle(
                    fontSize: 11,
                    color: active ? AppColors.primaryblue : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
