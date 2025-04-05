import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/data/service/api_service.dart';

class ProductRepo {
  ApiService apiService = ApiService();

  //
  Future<List<ProductModel>> fetchProducts() async {
    return await apiService.fetchProduct();
  }
}
