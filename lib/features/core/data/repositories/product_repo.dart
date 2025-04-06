import 'package:capstone_project/features/core/data/service/api_service.dart';
import 'package:capstone_project/features/core/domain/entities/product.dart';
import 'package:capstone_project/features/core/domain/repositories/product_repository.dart';

class ProductRepo implements ProductRepository {
  ApiService apiService = ApiService();

  @override
  Future<List<Product>> getAllProducts() async {
    final models =
        await apiService.fetchProduct(); // returns List<ProductModel>
    return models.map((model) => model.toEntity()).toList();
  }
}
