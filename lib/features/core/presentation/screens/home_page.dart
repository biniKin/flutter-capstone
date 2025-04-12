// import 'package:capstone_project/features/core/data/service/storage_service.dart';

import 'package:capstone_project/features/core/data/service/api_service.dart';
import 'package:capstone_project/features/core/presentation/screens/login_screen.dart';
import 'package:capstone_project/features/core/presentation/screens/products_page.dart';
import 'package:capstone_project/features/core/presentation/screens/profile_page.dart';
import 'package:capstone_project/features/core/presentation/screens/product_details.dart';

import 'package:capstone_project/features/core/presentation/widgets/product_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool _isBellTapped = false;
  bool _showSearchResults = false;
  String _userName = '';
  String _userEmail = '';

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
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName ?? 'User';
        _userEmail = user.email ?? '';
      });
    }
  }

  void _filterProducts() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredProducts = _allProducts;
        _showSearchResults = false;
      } else {
        _filteredProducts = _allProducts
            .where(
              (product) => product.title.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ),
            )
            .toList();
        _showSearchResults = true;
      }
    });
  }

  void _navigateToProductDetails(ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(product: product),
      ),
    );
    setState(() {
      _showSearchResults = false;
      _searchController.clear();
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
      height: 180,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? 'User';
    final email = user?.email ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage('https://s3-alpha-sig.figma.com/img/5784/2d50/c4b613fc7a5e890b4a3f4d0de8921c8a?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=RVc8x60qMTe7lhOb7IGeOY5PvIT29a2DtaweCadgXShjgopPVO7iXJUFixqOCZtoRCozqzI~otjQoV-a~KtrsGEgAmMwxc11F7TzrIkGvXYPuSrnr9UEaMD3RkNZLPH6vHzPfQI4aGMUweWNjZr2y5xS-k8rSEDnCrLSO9w7KOdrKKP85zIqmNfDOr1W9ezfOq2hpcVWXu~8hX9FsblAST7PYRbdVu8WkIGQrUy~Sd7pHBlFbA67uZAJMcPp9035G2ozXQmOiQyxK6lNprDBVw4xSkUVVb0evhpzJQeTKxD4t9J8t~dHcVR-ydrTaTvxPKlfib8IudXwNZyiJCjXCw__'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hello!",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isBellTapped = !_isBellTapped;
                  });
                },
                icon: Icon(
                  Icons.notifications,
                  size: 28,
                  color: _isBellTapped ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Box with Results
            Stack(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                if (_showSearchResults && _filteredProducts.isNotEmpty)
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return ListTile(
                            title: Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () => _navigateToProductDetails(product),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: [
                _buildBanner(
                  title: "Get Winter Discount",
                  subtitle: "20% Off For Children",
                  imageUrl: "https://s3-alpha-sig.figma.com/img/01dd/978f/318b065a77b0f2c3eb752665f2fff4b1?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HLMLvCmSq-5~wjRI92b6GQFyVLK4rBcVE6idN5RNT9f6RLC115Debxi-acciAdxPSqFNCez9sbBUsgW3MEpYwh4IeWM7HtIQ6SGN0PbKjErAAOeezNRLM3D5nga9-tmekkmqmMclHtJJcqSMzC-AHzlo8aPX8hQ5s-X006H1g-FcbCz0SK-W6PMmuJHK5HhFDbdtWjdfqTHUlUGT5GTKqE4zOMumMWmiWc5uMvdBH5PR8mooJq5shZs1G7JyihKf4b9uSLdHKp-ik1OSoySlzo4va3krwLyY2UisxAGbzVbrbx-HW78BE67bdGyWT2nRTxEAXqIQ20rPhz5N0Kj8og__",
                  bgColor: Colors.deepPurpleAccent,
                 
                ),
                _buildBanner(
                  title: "Flash Sale",
                  subtitle: "Up to 50% Off!",
                  imageUrl: "https://images.unsplash.com/photo-1607082350899-7e105aa886ae?w=500&auto=format&fit=crop&q=60",
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

            // Horizontal scrollable products list
            _filteredProducts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 230, // Keep the same height as before
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filteredProducts.length >= 4 ? 4 : _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ),

            const SizedBox(height: 20),

            // Featured Products Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Products',
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

            // Featured Products List
            _filteredProducts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filteredProducts.length >= 4 ? 4 : _filteredProducts.length,
                      itemBuilder: (context, index) {
                        // Show different products for featured section
                        final product = _filteredProducts[(_filteredProducts.length - 1 - index) % _filteredProducts.length];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
