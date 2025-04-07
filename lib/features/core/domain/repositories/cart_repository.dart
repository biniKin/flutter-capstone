import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:capstone_project/features/core/data/models/cart_model.dart';

abstract class CartRepository {
  Future<CartModel> getCart(String userId); // Return the entire cart model
  Future<void> addToCart(String userId, CartItem cartItem);
  Future<void> removeFromCart(String userId, String productId);
  Future<void> clearCart(String userId);
  Future<void> updateCart(String userId, List<CartItem> updatedCartItems);
}
