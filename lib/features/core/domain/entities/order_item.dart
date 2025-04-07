

import 'package:capstone_project/features/core/domain/entities/product.dart';

class OrderItem {
  final String userId;
  final List<Product> products;

  OrderItem({
    required this.userId,
    required this.products,
  });
}
