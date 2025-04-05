abstract class CartRepository {
  Future<List<CartItem>> getCartItems(String userId);
  Future<void> addToCart(String userId, Product product, int quantity);
  Future<void> updateCartItem(String userId, CartItem cartItem);
  Future<void> removeFromCart(String userId, String productId);
  Future<void> clearCart(String userId);
}
