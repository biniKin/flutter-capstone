class CartUseCases {
  final CartRepository repository;

  CartUseCases(this.repository);

  Future<List<CartItem>> getCartItems(String userId) {
    return repository.getCartItems(userId);
  }

  Future<void> addToCart(String userId, Product product, int quantity) {
    return repository.addToCart(userId, product, quantity);
  }

  Future<void> updateCartItem(String userId, CartItem cartItem) {
    return repository.updateCartItem(userId, cartItem);
  }

  Future<void> removeFromCart(String userId, String productId) {
    return repository.removeFromCart(userId, productId);
  }
}
