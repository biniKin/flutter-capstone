// import 'package:capstone_project/features/core/presentation/widgets/product_list.dart';
// import 'package:flutter/material.dart';
// import 'package:capstone_project/features/core/data/models/product_model.dart';

// class SearchPage extends StatefulWidget {
//   final List<ProductModel> allProducts;

//   const SearchPage({super.key, required this.allProducts});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   late List<ProductModel> filteredProducts;
//   String searchText = '';

//   @override
//   void initState() {
//     super.initState();
//     filteredProducts = widget.allProducts;
//   }

//   void _search(String value) {
//     setState(() {
//       searchText = value;
//       filteredProducts =
//           widget.allProducts
//               .where(
//                 (product) =>
//                     product.title.toLowerCase().contains(value.toLowerCase()),
//               )
//               .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 🔍 Search Bar
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       onChanged: _search,
//                       decoration: InputDecoration(
//                         hintText: 'Search',
//                         prefixIcon: const Icon(Icons.search),
//                         suffixIcon:
//                             searchText.isNotEmpty
//                                 ? IconButton(
//                                   icon: const Icon(Icons.close),
//                                   onPressed: () {
//                                     _search('');
//                                   },
//                                 )
//                                 : null,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               // 🔠 Search Result Title
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     const TextSpan(
//                       text: 'Results for ',
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     ),
//                     TextSpan(
//                       text: '"$searchText"',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 4),

//               // 🔢 Results Count
//               Text(
//                 '${filteredProducts.length} Results Found',
//                 style: const TextStyle(color: Color(0xFF6055D8), fontSize: 13),
//               ),

//               const SizedBox(height: 16),

//               // 🧱 Product Grid
//               Expanded(
//                 child: GridView.builder(
//                   itemCount: filteredProducts.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 12,
//                     crossAxisSpacing: 12,
//                     childAspectRatio: 0.75,
//                   ),
//                   itemBuilder: (context, index) {
//                     final product = filteredProducts[index];
//                     return ProductCard(product: product);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:capstone_project/features/core/data/models/product_model.dart';
// import 'package:capstone_project/features/core/presentation/widgets/product_list.dart';

// class SearchPage extends StatefulWidget {
//   final List<ProductModel> allProducts;

//   const SearchPage({super.key, required this.allProducts});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   late List<ProductModel> filteredProducts;
//   String searchText = '';

//   @override
//   void initState() {
//     super.initState();
//     filteredProducts = []; // Start with an empty list
//   }

//   void _search(String value) {
//     setState(() {
//       searchText = value;
//       filteredProducts =
//           widget.allProducts
//               .where(
//                 (product) =>
//                     product.title.toLowerCase().contains(value.toLowerCase()) ||
//                     product.category.toLowerCase().contains(
//                       value.toLowerCase(),
//                     ),
//               )
//               .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       onChanged: _search,
//                       decoration: InputDecoration(
//                         hintText: 'Search here',
//                         prefixIcon: const Icon(Icons.search),
//                         suffixIcon:
//                             searchText.isNotEmpty
//                                 ? IconButton(
//                                   icon: const Icon(Icons.close),
//                                   onPressed: () {
//                                     _search('');
//                                   },
//                                 )
//                                 : null,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Results for "$searchText"',
//                     style: const TextStyle(color: Colors.black, fontSize: 16),
//                   ),
//                   Text(
//                     '${filteredProducts.length} Results Found',
//                     style: const TextStyle(color: Colors.black, fontSize: 13),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               Expanded(
//                 child:
//                     searchText.isEmpty
//                         ? const Center(
//                           child: Text(
//                             'Discover products—find what you need!',
//                             style: TextStyle(fontSize: 16, color: Colors.grey),
//                           ),
//                         )
//                         : GridView.builder(
//                           itemCount: filteredProducts.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 mainAxisSpacing: 12,
//                                 crossAxisSpacing: 12,
//                                 childAspectRatio: 0.75,
//                               ),
//                           itemBuilder: (context, index) {
//                             final product = filteredProducts[index];
//                             return ProductCard(product: product);
//                           },
//                         ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/presentation/widgets/product_list.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // IconButton(
                  //   icon: const Icon(Icons.arrow_back),
                  //   onPressed: () => Navigator.pop(context),
                  // ),
                  Expanded(
                    child: TextField(
                      onChanged: _search,
                      decoration: InputDecoration(
                        hintText: 'Search here',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon:
                            searchText.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    _search('');
                                  },
                                )
                                : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
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
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    '${filteredProducts.length} Results Found',
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    searchText.isEmpty
                        ? const Center(
                          child: Text(
                            'Discover products—find what you need!',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
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
