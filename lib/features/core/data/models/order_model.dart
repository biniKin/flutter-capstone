class OrderModel {
  String id;
  String title;
  double price;
  String imageUrl;
  String category;

  OrderModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  //
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      price: json['price'],
      imageUrl: json['image'],
    );
  }

  //
  factory OrderModel.fromFirebase(Map<String, dynamic> data) {
    return OrderModel(
      id: data['id'],
      title: data['title'],
      category: data['catergory'],
      price: data['price'],
      imageUrl: data['image'],
    );
  }

  //
  Map<String, dynamic> toFirestore() {
    return {
      'id':id,
      'title':title,
      'category':category,
      'price':price,
      'image':imageUrl,
    };
  }
}
