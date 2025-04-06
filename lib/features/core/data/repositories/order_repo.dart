import 'package:capstone_project/features/core/data/models/order_model.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:capstone_project/features/core/domain/entities/order_item.dart';
import 'package:capstone_project/features/core/domain/repositories/order_repository.dart';

class OrderRepo implements OrderRepository {
  final StorageService storageService;

  // Constructor
  OrderRepo(this.storageService);

  @override
  Future<List<OrderItem>> getOrderItems(String userId, String orderId) async {
    try {
      // Fetch order by orderId for the given userId
      final order = await storageService.getOrderData(orderId);
      
      // If the order is found, map it to an OrderItem and return it
      if (order != null) {
        return [
          OrderItem(
            id: order.id,
            title: order.title,
            price: order.price,
            imageUrl: order.imageUrl,
            category: order.category,
          )
        ];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch order items: $e');
    }
  }

  @override
  Future<void> createOrder(String userId, List<CartItem> cartItems) async {
    try {
      // Create an order model from cart items
      final order = OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique order ID
        title: 'Order #${DateTime.now().millisecondsSinceEpoch}', // Example title
        price: cartItems.fold(0, (sum, item) => sum + item.price * item.quantity), // Calculate total price
        imageUrl: cartItems.isNotEmpty ? cartItems.first.imageUrl : '', // Example image URL, modify as needed
        category: cartItems.isNotEmpty ? cartItems.first.category : '', // Example category
      );
      
      // Save the order
      await storageService.saveOrder(order);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  @override
  Future<List<OrderItem>> getUserOrders(String userId) async {
    try {
      // Fetch orders for the given userId
      final orders = await storageService.getUserOrders(userId);
      
      // Map orders to OrderItem entities
      return orders.map((order) => OrderItem(
        id: order.id,
        title: order.title,
        price: order.price,
        imageUrl: order.imageUrl,
        category: order.category,
      )).toList();
    } catch (e) {
      throw Exception('Failed to fetch user orders: $e');
    }
  }
}
