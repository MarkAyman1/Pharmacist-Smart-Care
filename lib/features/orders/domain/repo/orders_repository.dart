import 'package:pharmacist/core/api/api_consumer.dart';
import 'package:pharmacist/features/orders/domain/models/online_order_model.dart';
import 'package:pharmacist/features/orders/domain/models/paginated_orders.dart';
import 'package:pharmacist/features/orders/domain/models/pickup_order_model.dart';

class OrdersRepository {
  final ApiConsumer api;

  OrdersRepository(this.api);

  // ===== ONLINE =====
  Future<PaginatedOrders<OnlineOrderModel>> getOnlineOrders({
    int page = 1,
  }) async {
    final response = await api.get(
      '/api/Pharmacist/orders/Today/Online',
      queryParameters: {'pageNumber': page, 'pageSize': 10},
    );

    if (response.data['succeeded'] == true) {
      return PaginatedOrders.fromJson(
        response.data['data'],
        (json) => OnlineOrderModel.fromJson(json),
      );
    } else {
      throw Exception(response.data['message']);
    }
  }

  // ===== PICKUP =====
  Future<PaginatedOrders<PickupOrderModel>> getPickupOrders({
    int page = 1,
  }) async {
    final response = await api.get(
      '/api/Pharmacist/orders/Today-pickup',
      queryParameters: {'pageNumber': page, 'pageSize': 10},
    );

    if (response.data['succeeded'] == true) {
      return PaginatedOrders.fromJson(
        response.data['data'],
        (json) => PickupOrderModel.fromJson(json),
      );
    } else {
      throw Exception(response.data['message']);
    }
  }

  // ===== UPDATE STATUS =====
  Future<void> updateOrderStatus({
    required String id,
    required int status,
  }) async {
    await api.patch(
      '/api/admin/orders/update-status/$id',
      queryParameters: {'newStatus': status},
    );
  }
}
