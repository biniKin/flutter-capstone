import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/domain/entities/order_item.dart';

class OrderModel {
  final String userId;
  final List<ProductModel> products;

  OrderItem toEntity() => OrderItem(
    userId: userId,
    products: products.map((p) => p.toEntity()).toList(),
  );

  OrderModel({required this.userId, required this.products});

  //
  factory OrderModel.fromEntity(OrderItem entity) {
    return OrderModel(
      userId: entity.userId,
      products: entity.products.map((e) => ProductModel.fromEntity(e)).toList(),
    );
  }

  ///
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['userId'],
      products:
          (json['products'] as List)
              .map((p) => ProductModel.fromJson(p))
              .toList(),
    );
  }
  //
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}
