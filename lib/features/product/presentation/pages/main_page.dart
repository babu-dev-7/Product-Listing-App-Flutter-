import 'package:flutter/material.dart';
import 'product_list_page.dart';
import 'favorite_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final pages = [
    const ProductListPage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[index],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C5CE7).withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() => index = value);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          indicatorColor: const Color(0xFF6C5CE7).withOpacity(0.12),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined),
              selectedIcon: Icon(
                Icons.storefront,
                color: Color(0xFF6C5CE7),
              ),
              label: "Shop",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline_rounded),
              selectedIcon: Icon(
                Icons.favorite_rounded,
                color: Color(0xFFE84393),
              ),
              label: "Favorites",
            ),
          ],
        ),
      ),
    );
  }
}