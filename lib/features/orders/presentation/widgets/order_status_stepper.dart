import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/presentation/utils/order_status_mapper.dart';

class OrderStatusStepper extends StatelessWidget {
  const OrderStatusStepper({
    super.key,
    required this.currentStatus,
    required this.isOnlineOrder,
  });

  final String currentStatus;
  final bool isOnlineOrder;

  /// Matches logical flow (not raw enum index order).
  static const List<String> _onlineFulfillmentSteps = [
    'Pending',
    'Confirmed',
    'Processing',
    'Ready to ship',
    'Delivery accepted',
    'Shipped',
    'Completed',
  ];

  static const List<String> _pickupFulfillmentSteps = [
    'Pending',
    'Confirmed',
    'Processing',
    'Waiting for pickup',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    final idx = OrderStatusMapper.stepperIndexFromApiStatus(currentStatus);
    final steps = isOnlineOrder
        ? _onlineFulfillmentSteps
        : _pickupFulfillmentSteps;

    if (idx < 0) {
      final message =
          OrderStatusMapper.terminalBannerForStepperCode(idx) ??
          'Order status update';
      final isPayment = idx == -3;
      final isRefund = idx == -5;
      final isExpired = idx == -4;

      final Color bg;
      final Color border;
      final Color iconColor;
      final IconData icon;

      if (isRefund) {
        bg = Colors.deepPurple.withValues(alpha: 0.12);
        border = Colors.deepPurple.withValues(alpha: 0.28);
        iconColor = Colors.deepPurple;
        icon = Icons.replay_rounded;
      } else if (isExpired) {
        bg = Colors.blueGrey.withValues(alpha: 0.12);
        border = Colors.blueGrey.withValues(alpha: 0.28);
        iconColor = Colors.blueGrey.shade700;
        icon = Icons.hourglass_disabled_rounded;
      } else if (isPayment) {
        bg = Colors.red.withValues(alpha: 0.12);
        border = Colors.red.withValues(alpha: 0.25);
        iconColor = Colors.red;
        icon = Icons.payment_rounded;
      } else if (idx == -2) {
        bg = Colors.amber.withValues(alpha: 0.14);
        border = Colors.amber.shade700.withValues(alpha: 0.35);
        iconColor = Colors.amber.shade900;
        icon = Icons.undo_rounded;
      } else {
        bg = Colors.red.withValues(alpha: 0.12);
        border = Colors.red.withValues(alpha: 0.25);
        iconColor = Colors.red;
        icon = Icons.cancel_rounded;
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Row(
        children: List.generate(steps.length, (index) {
          final active = index <= idx;

          return Expanded(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? AppColors.primaryblue
                        : Colors.grey.shade300,
                    boxShadow: active
                        ? [
                            BoxShadow(
                              color: AppColors.primaryblue.withValues(
                                alpha: 0.35,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    active ? Icons.check_rounded : Icons.circle_outlined,
                    size: active ? 16 : 10,
                    color: active ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  steps[index],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                    color: active
                        ? AppColors.primaryblue
                        : Colors.grey.shade500,
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
