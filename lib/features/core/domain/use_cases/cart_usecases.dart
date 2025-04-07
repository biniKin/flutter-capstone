import 'package:capstone_project/features/core/data/models/cart_model.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';

import 'package:capstone_project/features/core/domain/repositories/cart_repository.dart';

class CartUseCases {
  final CartRepository repository;

  CartUseCases(this.repository);

  Future<CartModel> getCartItems(String userId) {
    return repository.getCart(userId);
  }

  Future<void> addToCart(String userId, CartItem cartItem) {
    return repository.addToCart(userId, cartItem);
  }

  Future<void> removeFromCart(String userId, String productId) {
    return repository.removeFromCart(userId, productId);
  }

  Future<void> updateCart(String userId, List<CartItem> updatedCartItems) {
    return repository.updateCart(userId, updatedCartItems);
  }
}
