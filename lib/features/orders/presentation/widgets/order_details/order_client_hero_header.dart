import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_status_badge.dart';

class OrderClientHeroHeader extends StatelessWidget {
  const OrderClientHeroHeader({
    super.key,
    required this.clientName,
    required this.phone,
    required this.status,
    required this.orderId,
    required this.orderDateLabel,
  });

  final String clientName;
  final String phone;
  final String status;
  final String orderId;
  final String orderDateLabel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = LinearGradient(
      colors: isDark
          ? [
              AppColors.primaryLightColor.withValues(alpha: 0.35),
              AppColors.darkSurface,
            ]
          : [AppColors.primaryblue.withValues(alpha: 0.12), AppColors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryblue.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryblue.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primaryblue.withValues(alpha: 0.15),
                child: const Icon(
                  Icons.person_rounded,
                  color: AppColors.primaryblue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clientName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phone,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.darkMediumGrey
                            : AppColors.mediumGrey,
                      ),
                    ),
                  ],
                ),
              ),
              OrderStatusBadge(status: status),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              _Chip(icon: Icons.tag_rounded, label: '$orderId', isSmall: true),
              _Chip(icon: Icons.schedule_rounded, label: orderDateLabel),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label, this.isSmall = false});

  final IconData icon;
  final String label;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.secondaryDarkColor.withValues(alpha: 0.8)
            : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryblue),
          const SizedBox(width: 4),
          Text(
            isSmall ? label.substring(0, 8) : label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: null,
            ),
          ),
        ],
      ),
    );
  }
}
