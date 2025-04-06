import 'package:capstone_project/features/core/data/models/cart_model.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';

import 'package:capstone_project/features/core/domain/entities/product.dart';
import 'package:capstone_project/features/core/domain/repositories/cart_repository.dart';

class CartRepo implements CartRepository {
  final StorageService storageService = StorageService();

  @override
  Future<List<CartItem>> getCartItems(String userId) async {
    final List<CartModel> models = await storageService.getallCartItems(userId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addToCart(String userId, Product product, int quantity) async {
    await storageService.saveCart(userId, product, quantity);
  }


  @override
  Future<void> removeFromCart(String userId, String productId) async {
    await storageService.removeFromCart(userId, productId);
  }

  @override
  Future<void> clearCart(String userId) async {
    await storageService.clearCart(userId);
  }
}
