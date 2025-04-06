import 'package:capstone_project/features/core/domain/entities/cart_item.dart';
import 'package:capstone_project/features/core/domain/entities/product.dart';
import 'package:capstone_project/features/core/domain/repositories/cart_repository.dart';

class CartUseCases {
  final CartRepository repository;

  CartUseCases(this.repository);

  Future<List<CartItem>> getCartItems(String userId) {
    return repository.getCartItems(userId);
  }

  Future<void> addToCart(String userId, Product product, int quantity) {
    return repository.addToCart(userId, product, quantity);
  }

  Future<void> removeFromCart(String userId, String productId) {
    return repository.removeFromCart(userId, productId);
  }
}
