import 'package:capstone_project/features/core/data/models/cart_item_model.dart';
import 'package:capstone_project/features/core/data/models/cart_model.dart';
import 'package:capstone_project/features/core/data/service/storage_service.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:capstone_project/features/core/domain/repositories/cart_repository.dart';

class CartRepo implements CartRepository {
  final StorageService storageService = StorageService();

  @override
  Future<CartModel> getCart(String userId) async {
    try {
      print('Fetching cart for user: $userId');
      final cartModelSnapshot =
          await storageService.firestore
              .collection('carts')
              .doc(userId)
              .collection('items')
              .get();

      // Convert fetched data directly to CartItemModel
      List<CartItemModel> cartItems =
          cartModelSnapshot.docs.map((doc) {
            return CartItemModel.fromJson(doc.data());
          }).toList();

      return CartModel(
        userId: userId,
        items: cartItems,
      );
    } catch (e) {
      print('Error fetching cart for user $userId: $e');
      // Return empty cart instead of throwing error
      return CartModel(userId: userId, items: []);
    }
  }

  @override
  Future<void> addToCart(String userId, CartItem cartItem) async {
    return await storageService.addToCart(userId, cartItem);
  }

  @override
  Future<void> removeFromCart(String userId, String productId) async {
    return await storageService.removeFromCart(userId, productId);
  }

  @override
  Future<void> clearCart(String userId) async {
    return await storageService.clearCart(userId);
  }

  @override
  Future<void> updateCart(
    String userId,
    List<CartItem> updatedCartItems,
  ) async {
    return await storageService.updateCart(userId, updatedCartItems);
  }
}
