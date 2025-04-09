import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<ProductModel> products;
  const ProductsPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Products"), backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 230,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,

            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}
