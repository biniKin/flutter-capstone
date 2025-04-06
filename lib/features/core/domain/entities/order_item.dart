class OrderItem {
  final String id;
  final Product product;
  final int quantity;
  final double priceAtPurchase; // Price at the time of purchase
  final DateTime orderedAt;

  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.priceAtPurchase,
    required this.orderedAt,
  });
}
