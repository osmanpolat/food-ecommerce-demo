import 'package:flutter/material.dart';
import 'package:food_ecommerce/components/app_theme.dart';
import 'package:food_ecommerce/ui/screens/home_screen.dart';
import 'package:food_ecommerce/ui/screens/favorites_screen.dart';
import 'package:food_ecommerce/ui/screens/product_basket.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final _pages = const [
    HomeScreen(),
    FavoritesScreen(),
    ProductBasketScreen(userName: "osman_polat"),
  ];

  void _setCurrentPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          _currentIndex == 0
              ? AppBar(
                title: const Text("Home"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    onPressed: () => _setCurrentPage(1), // FAVORITES
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () => _setCurrentPage(2), // BASKET
                  ),
                  const SizedBox(width: 16),
                ],
              )
              : null,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _setCurrentPage,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'MyCart',
          ),
        ],
      ),
    );
  }
}
