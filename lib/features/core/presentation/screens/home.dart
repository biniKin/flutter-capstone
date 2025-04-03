import 'package:capstone_project/features/core/presentation/screens/home_page.dart';
import 'package:capstone_project/features/core/presentation/screens/products_page.dart';
import 'package:capstone_project/features/core/presentation/screens/profile_page.dart';
import 'package:capstone_project/features/core/presentation/screens/search_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final List pages = [HomePage(), SearchPage(), ProductsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
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
