import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_state.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';

class PickupCodeVerificationDialog extends StatefulWidget {
  const PickupCodeVerificationDialog({
    super.key,
    required this.orderId,
    required this.isOnlineOrder,
    required this.bloc,
  });

  final String orderId;
  final bool isOnlineOrder;
  final OrdersBloc bloc;

  @override
  State<PickupCodeVerificationDialog> createState() =>
      _PickupCodeVerificationDialogState();
}

class _PickupCodeVerificationDialogState
    extends State<PickupCodeVerificationDialog> {
  final TextEditingController controller = TextEditingController();
  String? errorText;
  bool isLoading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 18,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryblue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.isOnlineOrder
                    ? Icons.check_circle_outline
                    : Icons.lock_outline,
                size: 40,
                color: AppColors.primaryblue,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Verify before completing',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.isOnlineOrder
                  ? 'Mark this online order as completed? Once confirmed, the status will be updated immediately.'
                  : 'To complete this order, please verify the pickup code. If verification succeeds, the status will change to Completed.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            if (!widget.isOnlineOrder) ...[
              const SizedBox(height: 18),
              TextField(
                controller: controller,
                autocorrect: false,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Pickup code',
                  hintText: 'Enter code from customer',
                  errorText: errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface,
                      foregroundColor: theme.colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.of(context).pop(false);
                          },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryblue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (!widget.isOnlineOrder &&
                                controller.text.trim().isEmpty) {
                              setState(() {
                                errorText = 'Pickup code is required.';
                              });
                              return;
                            }

                            if (widget.isOnlineOrder) {
                              Navigator.of(context).pop(true);
                              return;
                            }

                            setState(() {
                              errorText = null;
                              isLoading = true;
                            });

                            final bloc = widget.bloc;
                            bloc.add(
                              VerifyPickupCode(
                                orderId: widget.orderId,
                                code: controller.text.trim(),
                              ),
                            );

                            final state = await bloc.stream.firstWhere(
                              (state) =>
                                  state is VerifyPickupCodeSuccess ||
                                  state is VerifyPickupCodeError,
                            );

                            if (!mounted) return;

                            if (state is VerifyPickupCodeSuccess) {
                              Navigator.of(context).pop(true);
                              return;
                            }

                            setState(() {
                              isLoading = false;
                              errorText = state is VerifyPickupCodeError
                                  ? state.message
                                  : 'Verification failed';
                            });
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: isLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Confirm'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
