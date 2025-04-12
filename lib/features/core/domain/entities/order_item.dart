import 'package:capstone_project/features/core/domain/entities/product.dart';

class OrderItem {
  final String id;
  final String userId;
  final List<Product> products;
  final double total;
  final String status;

  OrderItem({
    required this.id,
    required this.userId,
    required this.products,
    required this.total,
    this.status = 'active',
  });
}
