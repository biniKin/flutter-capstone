import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:capstone_project/features/core/domain/entities/order_item.dart';
import 'package:capstone_project/features/core/domain/repositories/order_repository.dart';

class OrderUseCases {
  final OrderRepository repository;

  OrderUseCases(this.repository);

  Future<List<OrderItem>> getOrderItems(String userId, String orderId) async {
    try {
      return await repository.getOrderItems(userId, orderId);
    } catch (e) {
      print(
        'Error fetching order items for user $userId and order $orderId: $e',
      );
      throw Exception('Failed to fetch order items: $e');
    }
  }

  Future<void> createOrder(String userId, List<CartItem> cartItems) async {
    // Business logic: Validate cart items before creating order
    try {
      // Business logic: Validate cart items before creating order
      if (cartItems.isEmpty) {
        throw Exception('Cannot create an order with an empty cart');
      }

      await repository.createOrder(userId, cartItems);
      print('Order created successfully for user $userId');
    } catch (e) {
      print('Error creating order for user $userId: $e');
      throw Exception('Failed to create order: $e');
    }
  }

  Future<List<OrderItem?>> getUserOrders(String userId) async {
    try {
      return await repository.getUserOrders(userId);
    } catch (e) {
      throw Exception('Failed to fetch user orders: $e');
    }
  }
}
