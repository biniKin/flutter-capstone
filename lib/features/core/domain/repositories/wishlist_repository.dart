abstract class WishlistRepository {
  Future<Wishlist> getWishlist(String userId);
  Future<void> addToWishlist(String userId, Product product);
  Future<void> removeFromWishlist(String userId, String productId);
}
