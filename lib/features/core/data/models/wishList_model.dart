import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/domain/entities/wishlist.dart';

class WishlistModel {
  final String userId;
  final List<ProductModel> products;

  WishlistModel({
    required this.userId,
    required this.products,
  });

  Wishlist toEntity() => Wishlist(
    userId: userId,
    products: products.map((p) => p.toEntity()).toList(),
  );

  factory WishlistModel.fromEntity(Wishlist entity) {
    return WishlistModel(
      userId: entity.userId,
      products: entity.products.map((e) => ProductModel.fromEntity(e)).toList(),
    );
  }

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      userId: json['userId'],
      products: (json['products'] as List)
          .map((p) => ProductModel.fromJson(p))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}
