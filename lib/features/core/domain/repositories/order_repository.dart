abstract class OrderRepository {
  Future<List<OrderItem>> getOrderItems(String userId, String orderId);
  Future<void> createOrder(String userId, List<CartItem> cartItems);
  Future<List<OrderItem>> getUserOrders(String userId);
}
