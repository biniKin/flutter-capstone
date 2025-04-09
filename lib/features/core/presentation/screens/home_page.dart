// import 'package:capstone_project/features/core/data/service/storage_service.dart';

import 'package:capstone_project/features/core/data/service/api_service.dart';
import 'package:capstone_project/features/core/presentation/screens/login_screen.dart';
import 'package:capstone_project/features/core/presentation/screens/products_page.dart';
import 'package:capstone_project/features/core/presentation/widgets/product_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductModel>> _products;
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _allProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _products = ApiService().fetchProduct();
    _searchController.addListener(_filterProducts);
    _products.then((products) {
      _allProducts = products;
      _filteredProducts = products;
      setState(() {}); // Trigger UI update
    });
  }

  void _filterProducts() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts =
            _allProducts
                .where(
                  (product) => product.title.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
                )
                .toList();
      }
    });
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  
  Widget _buildBanner({
    required String title,
    required String subtitle,
    required String imageUrl,
    required Color bgColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, height: 80, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false, // Prevent the default back button
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User profile section
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/user.png',
                    ), // Replace with your image
                    radius: 24,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hello!",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "John William",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.notifications_none, size: 28),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Box
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: [
                _buildBanner(
                  title: "Get Winter Discount",
                  subtitle: "20% Off For Children",
                  imageUrl:
                      "https://img.freepik.com/free-photo/kid-fashion-child-smiling-boy-wearing-winter-clothes-hat-scarf-white-studio-background_155003-41068.jpg",
                  bgColor: Colors.deepPurpleAccent,
                ),
                _buildBanner(
                  title: "Flash Sale",
                  subtitle: "Up to 50% Off!",
                  imageUrl:
                      "https://img.freepik.com/free-photo/shopping-concept-happy-african-american-guy-holding-bags_1258-187541.jpg",
                  bgColor: Colors.orangeAccent,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Section title + See all
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsPage(products: _allProducts),
                      ),
                    );
                  },
                  child: const Text('See All'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Grid of Products (2 per row)
            _filteredProducts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                  itemCount:
                      _filteredProducts.length >= 4
                          ? 4
                          : _filteredProducts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 230,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: .65,
                  ),
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    return ProductCard(product: product);
                  },
                ),
          ],
        ),
      ),
    );
  }
}
