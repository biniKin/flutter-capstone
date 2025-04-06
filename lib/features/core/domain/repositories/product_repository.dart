import 'package:capstone_project/features/core/domain/entities/product.dart';

abstract class ProductRepository {
  //Future<List<Product>> getProductsByCategory(String category);
  //Future<Product> getProductById(String id);
  Future<List<Product>> getAllProducts();
}
