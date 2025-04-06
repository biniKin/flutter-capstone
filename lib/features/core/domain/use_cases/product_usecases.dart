import 'package:capstone_project/features/core/domain/entities/product.dart';
import 'package:capstone_project/features/core/domain/repositories/product_repository.dart';

class ProductUseCases {
  final ProductRepository repository;

  ProductUseCases(this.repository);

  //Future<List<Product>> getProductsByCategory(String category) {
  //  return repository.getProductsByCategory(category);
  //}

  //Future<Product> getProductById(String id) {
  //  return repository.getProductById(id);
  //}

  Future<List<Product>> getAllProducts() {
    return repository.getAllProducts();
  }
}
