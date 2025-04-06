class CartItem {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String category;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}
