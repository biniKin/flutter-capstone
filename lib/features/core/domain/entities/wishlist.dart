import 'package:capstone_project/features/core/domain/entities/product.dart';

class Wishlist {
  final String id;
  final String userId;
  final List<Product> products;

  Wishlist({
    required this.id,
    required this.userId,
    required this.products,
  });
}
