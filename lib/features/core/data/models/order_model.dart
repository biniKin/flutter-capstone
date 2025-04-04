class OrderModel {
  int id;
  String title;
  double price;
  String image;
  String category;

  OrderModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
  });
}
