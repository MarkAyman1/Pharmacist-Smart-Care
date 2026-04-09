import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class OrdersFilterTabs extends StatelessWidget {
  final String selected;
  final Function(String) onChanged;

  const OrdersFilterTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTab(context, "Delivery", isDark),
          _buildTab(context, "Pickup", isDark),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String type, bool isDark) {
    final isSelected = selected == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryblue : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.darkOnSurface : AppColors.darkGrey),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
