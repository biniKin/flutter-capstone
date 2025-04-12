import 'package:flutter/material.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/presentation/widgets/product_list.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final List<ProductModel> allProducts;

  const SearchPage({super.key, required this.allProducts});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<ProductModel> filteredProducts;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = []; // Start with an empty list
  }

  void _search(String value) {
    if (!mounted) return; // Check if the widget is still mounted
    setState(() {
      searchText = value;
      filteredProducts =
          widget.allProducts
              .where(
                (product) =>
                    product.title.toLowerCase().contains(value.toLowerCase()) ||
                    product.category.toLowerCase().contains(
                      value.toLowerCase(),
                    ),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Search',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        onChanged: _search,
                        decoration: InputDecoration(
                          hintText: 'Search here',
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: searchText.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.close, color: Colors.grey),
                                  onPressed: () {
                                    _search('');
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Results for "$searchText"',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${filteredProducts.length} Results Found',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    searchText.isEmpty
                        ? Center(
                          child: Text(
                            'Discover products—find what you need!',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                        : GridView.builder(
                          itemCount: filteredProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.75,
                              ),
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ProductCard(product: product);
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
