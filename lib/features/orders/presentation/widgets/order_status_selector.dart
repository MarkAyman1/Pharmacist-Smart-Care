import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_state.dart';
import 'package:pharmacist/features/orders/presentation/bloc/ordersbloc.dart';
import 'package:pharmacist/features/orders/presentation/widgets/pickup_code_verification_dialog.dart';
import 'package:pharmacist/features/orders/presentation/utils/order_status_mapper.dart';

class OrderStatusSelector extends StatefulWidget {
  const OrderStatusSelector({
    super.key,
    required this.orderId,
    required this.isOnlineOrder,
    required this.apiStatus,
    this.onStatusUpdated,
  });

  final String orderId;
  final bool isOnlineOrder;
  final String apiStatus;
  final ValueChanged<String>? onStatusUpdated;

  @override
  State<OrderStatusSelector> createState() => _OrderStatusSelectorState();
}

class _OrderStatusSelectorState extends State<OrderStatusSelector> {
  late int _selectedCode;
  late int _currentValue;
  late Key _dropdownKey;
  int? _pendingStatus;

  @override
  void initState() {
    super.initState();
    _selectedCode = OrderStatusMapper.codeFromApiStatus(widget.apiStatus);
    _currentValue = _selectedCode;
    _dropdownKey = UniqueKey();
    _pendingStatus = null;
  }

  @override
  void didUpdateWidget(covariant OrderStatusSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.apiStatus != widget.apiStatus) {
      _selectedCode = OrderStatusMapper.codeFromApiStatus(widget.apiStatus);
      _currentValue = _selectedCode;
      _dropdownKey = UniqueKey();
      _pendingStatus = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final selectablePairs = OrderStatusMapper.selectablePairs.where((pair) {
      if (widget.isOnlineOrder && pair.$1 == OrderStatusMapper.completed) {
        return false;
      }
      if (widget.isOnlineOrder &&
          pair.$1 == OrderStatusMapper.deliveryAccepted) {
        return false;
      }
      if (widget.isOnlineOrder &&
          pair.$1 == OrderStatusMapper.waitingForPickup) {
        return false;
      }
      if (!widget.isOnlineOrder && pair.$1 == OrderStatusMapper.shipped) {
        return false;
      }
      if (!widget.isOnlineOrder && pair.$1 == OrderStatusMapper.readyToShip) {
        return false;
      }
      if (!widget.isOnlineOrder &&
          pair.$1 == OrderStatusMapper.deliveryAccepted) {
        return false;
      }
      return true;
    }).toList();

    if (!selectablePairs.any((pair) => pair.$1 == _currentValue)) {
      selectablePairs.insert(0, (
        _currentValue,
        OrderStatusMapper.labelForCode(_currentValue),
      ));
    }

    final ordersBloc = context.read<OrdersBloc>();

    return BlocListener<OrdersBloc, OrdersState>(
      listenWhen: (previous, current) =>
          current is OrderStatusUpdated || current is OrdersError,
      listener: (context, state) {
        if (_pendingStatus == null) return;

        if (state is OrderStatusUpdated) {
          if (!mounted || _pendingStatus == null) return;
          final newStatus = OrderStatusMapper.labelForCode(_pendingStatus!);
          setState(() {
            _currentValue = _selectedCode = _pendingStatus!;
            _pendingStatus = null;
          });
          widget.onStatusUpdated?.call(newStatus);
        }

        if (state is OrdersError) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
          _pendingStatus = null;
        }
      },
      child: Column(
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
            items: selectablePairs
                .map(
                  (e) => DropdownMenuItem<int>(
                    value: e.$1,
                    enabled:
                        !(widget.isOnlineOrder &&
                            e.$1 == OrderStatusMapper.completed) &&
                        !(!widget.isOnlineOrder &&
                            e.$1 == OrderStatusMapper.shipped),
                    child: Text(e.$2),
                  ),
                )
                .toList(),
            onChanged: (value) async {
              if (value == null) return;

              if (value != OrderStatusMapper.completed) {
                _pendingStatus = value;
                ordersBloc.add(
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
                    value: ordersBloc,
                    child: PickupCodeVerificationDialog(
                      orderId: widget.orderId,
                      isOnlineOrder: widget.isOnlineOrder,
                      bloc: ordersBloc,
                    ),
                  ),
                );
                if (!mounted) return;
                if (confirmed == true) {
                  _pendingStatus = value;
                  ordersBloc.add(
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
      ),
    );
  }
}
