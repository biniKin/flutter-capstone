import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';

import 'package:capstone_project/features/core/domain/entities/order_item.dart';

import 'package:capstone_project/features/core/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final StorageService storageService;

  OrderRepositoryImpl(this.storageService);

  @override
  Future<void> createOrder(String userId, List<CartItem> cartItems) {
    return storageService.createOrder(userId, cartItems);
  }

  @override
  Future<List<OrderItem>> getOrderItems(String userId, String orderId) {
    return storageService.getOrderItems(userId, orderId);
  }

  @override
  Future<List<OrderItem>> getUserOrders(String userId) {
    return storageService.getUserOrders(userId);
  }
}
