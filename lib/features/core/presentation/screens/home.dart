import 'package:flutter/material.dart';
import 'package:capstone_project/features/core/data/models/product_model.dart';
import 'package:capstone_project/features/core/presentation/screens/home_page.dart';
import 'package:capstone_project/features/core/presentation/screens/products_page.dart';
import 'package:capstone_project/features/core/presentation/screens/profile_page.dart';
import 'package:capstone_project/features/core/presentation/screens/search_page.dart';
import 'package:capstone_project/features/core/data/service/api_service.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/mdi.dart';

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
      ProductsPage(products: _allProducts),
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
        items: [
          BottomNavigationBarItem(
            icon: Iconify(Ic.round_home, color: currentIndex == 0 ? const Color(0xFF6055D8) : Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Iconify(Ic.round_search, color: currentIndex == 1 ? const Color(0xFF6055D8) : Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Iconify(Mdi.shopping, color: currentIndex == 2 ? const Color(0xFF6055D8) : Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Iconify(Bi.person, color: currentIndex == 3 ? const Color(0xFF6055D8) : Colors.grey),
            label: '',
          ),
        ],
      ),
    );
  }
}
