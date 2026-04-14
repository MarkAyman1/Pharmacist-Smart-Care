import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/domain/models/online_order_model.dart';

class OrderOnlineInfoSection extends StatelessWidget {
  const OrderOnlineInfoSection({super.key, required this.order});

  final OnlineOrderModel order;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          _InfoTile(
            icon: Icons.location_on_rounded,
            title: 'Address',
            body: order.deliveryAddress,
            isDark: isDark,
          ),
          const SizedBox(height: 10),
          _InfoTile(
            icon: Icons.social_distance_rounded,
            title: 'Distance from branch',
            body: '${order.distanceFromBranch.toStringAsFixed(1)} km',
            isDark: isDark,
          ),
          if (order.additionalInfo.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            _InfoTile(
              icon: Icons.notes_rounded,
              title: 'Notes',
              body: order.additionalInfo,
              isDark: isDark,
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.isDark,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryblue.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryblue, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isDark
                            ? AppColors.darkMediumGrey
                            : AppColors.mediumGrey,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
