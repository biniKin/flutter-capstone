import 'package:capstone_project/features/core/domain/entities/order_repository.dart
abstract class OrderRepository {
  Future<List<OrderItem>> getOrderItems(String userId, String orderId);
  Future<void> createOrder(String userId, List<CartItem> cartItems);
  Future<List<OrderItem>> getUserOrders(String userId);
}
