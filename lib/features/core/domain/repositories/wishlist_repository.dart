import 'package:capstone_project/features/core/domain/entities/product.dart';
import 'package:capstone_project/features/core/domain/entities/wishlist.dart';

abstract class WishlistRepository {
  Future<Wishlist> getWishlist(String userId);
  Future<void> addToWishlist(String userId, Product product);
  Future<void> removeFromWishlist(String userId, String productId);
}
