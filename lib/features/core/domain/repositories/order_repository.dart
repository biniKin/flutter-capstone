import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:capstone_project/features/core/domain/entities/order_item.dart';
import 'package:capstone_project/features/core/domain/entities/product.dart';

abstract class OrderRepository {
  Future<List<OrderItem>> getOrderItems(String userId, String orderId);
  Future<void> createOrder(String userId, List<CartItem> cartItems);
  Future<List<OrderItem?>> getUserOrders(String userId);
}
