import 'package:capstone_project/features/core/domain/entities/order_item.dart';

class OrderModel{
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String category;

  OrderItem toEntity() => OrderItem(
    id: id,
    title: title,
    category: category,
    price: price,
    imageUrl: imageUrl,
  );

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
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      category: data['catergory'] ?? '',
      price: data['price'] ?? 0,
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
