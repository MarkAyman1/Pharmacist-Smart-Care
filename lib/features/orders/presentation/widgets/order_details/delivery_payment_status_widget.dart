import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class DeliveryPaymentStatusWidget extends StatelessWidget {
  const DeliveryPaymentStatusWidget({
    super.key,
    required this.isPaid,
    required this.status,
  });

  final bool isPaid;
  final String status;

  bool get _effectiveIsPaid =>
      isPaid ||
      status.toLowerCase() == 'shipped' ||
      status.toLowerCase() == 'completed';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveIsPaid = _effectiveIsPaid;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: effectiveIsPaid
                ? Colors.green.withValues(alpha: 0.3)
                : Colors.red.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: (effectiveIsPaid ? Colors.green : Colors.red).withValues(
                alpha: 0.1,
              ),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: effectiveIsPaid
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                effectiveIsPaid ? Icons.check_circle : Icons.cancel,
                color: effectiveIsPaid ? Colors.green : Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Status for delivery',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isDark
                          ? AppColors.darkMediumGrey
                          : AppColors.mediumGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    effectiveIsPaid ? 'Delivery Paid' : 'Delivery Unpaid',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: effectiveIsPaid ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (!effectiveIsPaid)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Pending',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
