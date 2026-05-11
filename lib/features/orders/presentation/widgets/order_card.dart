import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_status_badge.dart';
import 'package:pharmacist/features/orders/presentation/widgets/order_type_badge.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.clientName,
    required this.status,
    required this.type,
    required this.totalPrice,
    required this.itemsCount,
    required this.onTap,
    this.subtitle,
    this.orderDateLabel,
  });

  final String clientName;
  final String status;
  final String type;
  final double totalPrice;
  final int itemsCount;
  final VoidCallback onTap;
  final String? subtitle;
  final String? orderDateLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      AppColors.darkSurface,
                      AppColors.secondaryDarkColor.withValues(alpha: 0.9),
                    ]
                  : [
                      AppColors.white,
                      AppColors.lightGrey.withValues(alpha: 0.35),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: AppColors.primaryblue.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryblue.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clientName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (subtitle != null && subtitle!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark
                                    ? AppColors.darkMediumGrey
                                    : AppColors.mediumGrey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    OrderStatusBadge(status: status),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    OrderTypeBadge(type: type),
                    const SizedBox(width: 12),
                    Text(
                      '$itemsCount items',
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (orderDateLabel != null) ...[
                      const Spacer(),
                      Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: AppColors.primaryblue.withValues(alpha: 0.8),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          orderDateLabel!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isDark
                                ? AppColors.darkMediumGrey
                                : AppColors.mediumGrey,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.darkMediumGrey
                            : AppColors.mediumGrey,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'EGP ${totalPrice.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryblue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: AppColors.primaryblue.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
