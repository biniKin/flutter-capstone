import 'package:flutter/material.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/presentation/screens/home_page.dart';
import 'package:capstone_project/features/core/presentation/screens/products_page.dart';
import 'package:capstone_project/features/core/presentation/screens/profile_page.dart';
import 'package:capstone_project/features/core/presentation/screens/search_page.dart';
import 'package:capstone_project/features/core/data/service/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<ProductModel> _allProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch product data when the widget initializes
  }

  // Fetch products from the API
  Future<void> _fetchProducts() async {
    final products = await ApiService().fetchProduct();
    if (mounted) {
      setState(() {
        _allProducts = products;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List pages = [
      HomeScreen(),
      SearchPage(allProducts: _allProducts),
      ProductsPage(products: []),
      ProfilePage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 24), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, size: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24),
            label: '',
          ),
        ],
      ),
    );
  }
}
