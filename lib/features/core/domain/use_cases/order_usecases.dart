import 'package:capstone_project/features/core/domain/entities/order_item.dart';
import 'package:capstone_project/features/core/domain/repositories/order_repository.dart';
class OrderUseCases {
  final OrderRepository repository;

  OrderUseCases(this.repository);

  Future<List<OrderItem>> getOrderItems(String userId, String orderId) {
    return repository.getOrderItems(userId, orderId);
  }

  Future<void> createOrder(String userId, List<CartItem> cartItems) {
    // Business logic: Validate cart items before creating order
    if (cartItems.isEmpty) {
      throw Exception('Cannot create an order with an empty cart');
    }
    return repository.createOrder(userId, cartItems);
  }

  Future<List<OrderItem>> getUserOrders(String userId) {
    return repository.getUserOrders(userId);
  }
}
