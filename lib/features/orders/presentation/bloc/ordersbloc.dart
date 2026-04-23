import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/failure.dart';
import 'package:pharmacist/features/orders/domain/models/online_order_model.dart';
import 'package:pharmacist/features/orders/domain/models/paginated_orders.dart';
import 'package:pharmacist/features/orders/domain/models/pickup_order_model.dart';
import 'package:pharmacist/features/orders/domain/repo/orders_repository.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_event.dart';
import 'package:pharmacist/features/orders/presentation/bloc/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository repo;

  OrdersBloc(this.repo) : super(OrdersInitial()) {
    // ===== ONLINE =====
    on<GetOnlineOrders>((event, emit) async {
      final OnlineOrdersLoaded? previousOnline = state is OnlineOrdersLoaded
          ? state as OnlineOrdersLoaded
          : null;

      if (!event.append) {
        emit(OrdersLoading());
      }
      try {
        final data = await repo.getOnlineOrders(page: event.page);
        if (event.append && previousOnline != null) {
          final prev = previousOnline.data;
          emit(
            OnlineOrdersLoaded(
              PaginatedOrders<OnlineOrderModel>(
                items: [...prev.items, ...data.items],
                totalPages: data.totalPages,
                pageNumber: data.pageNumber,
                hasNext: data.hasNext,
              ),
            ),
          );
        } else {
          emit(OnlineOrdersLoaded(data));
        }
      } catch (e) {
        if (!event.append) {
          if (e is DioException) {
            emit(OrdersError(ServiceFailure.fromDio(e).message));
          } else {
            emit(OrdersError("Unexpected error"));
          }
        }
      }
    });

    // ===== PICKUP =====
    on<GetPickupOrders>((event, emit) async {
      final PickupOrdersLoaded? previousPickup = state is PickupOrdersLoaded
          ? state as PickupOrdersLoaded
          : null;

      if (!event.append) {
        emit(OrdersLoading());
      }
      try {
        final data = await repo.getPickupOrders(page: event.page);
        if (event.append && previousPickup != null) {
          final prev = previousPickup.data;
          emit(
            PickupOrdersLoaded(
              PaginatedOrders<PickupOrderModel>(
                items: [...prev.items, ...data.items],
                totalPages: data.totalPages,
                pageNumber: data.pageNumber,
                hasNext: data.hasNext,
              ),
            ),
          );
        } else {
          emit(PickupOrdersLoaded(data));
        }
      } catch (e) {
        if (!event.append) {
          if (e is DioException) {
            emit(OrdersError(ServiceFailure.fromDio(e).message));
          } else {
            emit(OrdersError("Unexpected error"));
          }
        }
      }
    });

    // ===== UPDATE =====
    on<UpdateOrderStatus>((event, emit) async {
      try {
        await repo.updateOrderStatus(id: event.orderId, status: event.status);
        emit(OrderStatusUpdated());
        if (event.isOnlineOrder) {
          final data = await repo.getOnlineOrders(page: 1);
          emit(OnlineOrdersLoaded(data));
        } else {
          final data = await repo.getPickupOrders(page: 1);
          emit(PickupOrdersLoaded(data));
        }
      } catch (e) {
        if (e is DioException) {
          emit(OrdersError(ServiceFailure.fromDio(e).message));
        } else {
          emit(OrdersError("Unexpected error"));
        }
      }
    });

    // ===== verify pickup code =====
    on<VerifyPickupCode>((event, emit) async {
      emit(VerifyPickupCodeLoading());
      try {
        final success = await repo.verifyPickupCode(
          orderId: event.orderId,
          code: event.code,
        );
        if (success) {
          emit(VerifyPickupCodeSuccess("Pickup code verified successfully"));
        } else {
          emit(VerifyPickupCodeError("Invalid pickup code"));
        }
      } catch (e) {
        if (e is DioException) {
          emit(VerifyPickupCodeError(ServiceFailure.fromDio(e).message));
        } else {
          emit(VerifyPickupCodeError("Unexpected error"));
        }
      }
    });
  }
}
