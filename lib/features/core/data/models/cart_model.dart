import 'package:capstone_project/features/core/data/models/cart_item_model.dart';
import 'package:capstone_project/features/core/domain/entities/cart_item.dart';

class CartModel {
  final String userId;
  final List<CartItemModel> items;

  CartModel({
    required this.userId,
    required this.items,
  });

  factory CartModel.fromEntity(String userId, List<CartItem> entities) {
    return CartModel(
      userId: userId,
      items: entities.map((item) => CartItemModel.fromEntity(item)).toList(),
    );
  }

  List<CartItem> toEntityList() {
    return items.map((item) => item.toEntity()).toList();
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
