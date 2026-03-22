// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:product/features/product/presentation/pages/cart_page.dart';
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
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
          ),
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() => index = value);
          },
          backgroundColor: Colors.white,
          elevation: 0,
          height: 65,
          indicatorColor: const Color(0xFFF0EEFF),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined, color: Color(0xFFB2BEC3)),
              selectedIcon: Icon(
                Icons.storefront,
                color: Color(0xFF6C5CE7),
              ),
              label: "Shop",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline_rounded, color: Color(0xFFB2BEC3)),
              selectedIcon: Icon(
                Icons.favorite_rounded,
                color: Color(0xFFE84393),
              ),
              label: "Wishlist",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined, color: Color(0xFFB2BEC3)),
              selectedIcon: Icon(
                Icons.shopping_bag,
                color: Color(0xFF0984E3),
              ),
              label: "Cart",
            ),
          ],
        ),
      ),
    );
  }
}