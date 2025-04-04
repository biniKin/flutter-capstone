import 'dart:convert';

import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ProductModel>> fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
