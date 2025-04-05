import 'package:capstone_project/features/core/domain/entities/product.dart';
import 'package:capstone_project/features/core/domain/entities/wishlist.dart';
import 'package:capstone_project/features/core/domain/repositories/wishlist_repository.dart';

class WishlistUseCases {
  final WishlistRepository repository;

  WishlistUseCases(this.repository);

  Future<Wishlist> getWishlist(String userId) {
    return repository.getWishlist(userId);
  }

  Future<void> addToWishlist(String userId, Product product) {
    return repository.addToWishlist(userId, product);
  }

  Future<void> removeFromWishlist(String userId, String productId) {
    return repository.removeFromWishlist(userId, productId);
  }
}
