import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';
import 'package:pharmacist/features/orders/presentation/widgets/pickup_code_verification_dialog.dart';
import 'package:pharmacist/features/orders/presentation/utils/order_status_mapper.dart';

class OrderStatusSelector extends StatefulWidget {
  const OrderStatusSelector({
    super.key,
    required this.orderId,
    required this.isOnlineOrder,
    required this.apiStatus,
  });

  final String orderId;
  final bool isOnlineOrder;
  final String apiStatus;

  @override
  State<OrderStatusSelector> createState() => _OrderStatusSelectorState();
}

class _OrderStatusSelectorState extends State<OrderStatusSelector> {
  late int _selectedCode;
  late int _currentValue;
  late Key _dropdownKey;

  @override
  void initState() {
    super.initState();
    _selectedCode = OrderStatusMapper.codeFromApiStatus(widget.apiStatus);
    _currentValue = _selectedCode;
    _dropdownKey = UniqueKey();
  }

  @override
  void didUpdateWidget(covariant OrderStatusSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.apiStatus != widget.apiStatus) {
      _selectedCode = OrderStatusMapper.codeFromApiStatus(widget.apiStatus);
      _currentValue = _selectedCode;
      _dropdownKey = UniqueKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Update status',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<int>(
          key: _dropdownKey,
          value: _currentValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? AppColors.darkSurface : AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.primaryblue.withAlpha(64),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.primaryblue.withAlpha(51),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primaryblue,
                width: 2,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(16),
          items: OrderStatusMapper.selectablePairs
              .map((e) => DropdownMenuItem<int>(value: e.$1, child: Text(e.$2)))
              .toList(),
          onChanged: (value) async {
            if (value == null) return;

            if (value != OrderStatusMapper.completed) {
              setState(() {
                _currentValue = value;
                _selectedCode = value;
              });
              context.read<OrdersBloc>().add(
                UpdateOrderStatus(
                  orderId: widget.orderId,
                  status: value,
                  isOnlineOrder: widget.isOnlineOrder,
                ),
              );
            } else {
              final confirmed = await showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) => BlocProvider.value(
                  value: context.read<OrdersBloc>(),
                  child: PickupCodeVerificationDialog(
                    orderId: widget.orderId,
                    isOnlineOrder: widget.isOnlineOrder,
                    bloc: context.read<OrdersBloc>(),
                  ),
                ),
              );
              if (confirmed == true) {
                setState(() {
                  _currentValue = value;
                  _selectedCode = value;
                });
                context.read<OrdersBloc>().add(
                  UpdateOrderStatus(
                    orderId: widget.orderId,
                    status: value,
                    isOnlineOrder: widget.isOnlineOrder,
                  ),
                );
              } else {
                setState(() {
                  _dropdownKey = UniqueKey();
                  _currentValue = _selectedCode;
                });
              }
            }
          },
        ),
      ],
    );
  }
}
