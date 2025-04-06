import 'package:capstone_project/features/core/domain/entities/product.dart';

class ProductModel {
  String id;
  String title;
  double price;
  String description;
  String category;
  String imageUrl;
  double rate;
  double count;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rate,
    required this.count,
  });

  Product toEntity() => Product(
    id: id,
    title: title,
    description: description,
    price: price,
    imageUrl: imageUrl,
    category: category,
  );

  //converting Json to Object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString() ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? 0.0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image'] ?? '',
      rate: (json['rate'] != null) ? json['rate'] : 0.0,
      count: json['count'] ?? 0,
    );
  }
  //converting obj to json format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': imageUrl,
      'rate': rate,
      'count': count,
    };
  }
}
