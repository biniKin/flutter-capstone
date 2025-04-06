import 'package:capstone_project/features/core/domain/entities/cart_item.dart';

class CartModel {
  String id;
  int quantity;
  String title;
  double price;
  String imageUrl;
  String category;

  CartModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  CartItem toEntity() => CartItem(
    id: id,
    title: title,
    category: category,
    price: price,
    imageUrl: imageUrl,
    quantity: quantity,
  );

  //
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      price: json['price'],
      imageUrl: json['image'],
    );
  }

  //
  factory CartModel.fromFirebase(Map<String, dynamic> data) {
    return CartModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      category: data['catergory'] ?? '',
      price: (data['price'] ?? 0.0) is double ? data['price'] : 0.0,
      imageUrl: data['image'] ?? '',
    );
  }

  //
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'image': imageUrl,
    };
  }
}
