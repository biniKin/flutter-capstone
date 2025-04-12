import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/domain/entities/order_item.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<ProductModel> products;
  final double total;
  final String status;

  OrderModel({
    required this.id,
    required this.userId,
    required this.products,
    required this.total,
    this.status = 'active',
  });

  OrderItem toEntity() => OrderItem(
    id: id,
    userId: userId,
    products: products.map((p) => p.toEntity()).toList(),
    total: total,
    status: status,
  );

  factory OrderModel.fromEntity(OrderItem entity) {
    return OrderModel(
      id: entity.id,
      userId: entity.userId,
      products: entity.products.map((e) => ProductModel.fromEntity(e)).toList(),
      total: entity.total,
      status: entity.status,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      products: (json['products'] as List?)
              ?.map((p) => ProductModel.fromJson(p))
              .toList() ??
          [],
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products.map((p) => p.toJson()).toList(),
      'total': total,
      'status': status,
    };
  }
}
