import 'package:capstone_project/features/core/domain/entities/product.dart';

class Wishlist {
  final String userId;
  final List<Product> products;

  Wishlist({
    required this.userId,
    required this.products,
  });
}
