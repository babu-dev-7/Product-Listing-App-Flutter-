import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/hive/hive_service.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 22),
          color: const Color(0xFF2D3436),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              final isFav = HiveService.isFavorite(product.id);
              return IconButton(
                icon: Icon(
                  isFav
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: isFav
                      ? const Color(0xFFE84393)
                      : const Color(0xFFB2BEC3),
                ),
                onPressed: () {
                  context.read<ProductBloc>().add(
                    ToggleFavoriteEvent(product.id),
                  );
                },
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFEEEEEE), height: 1),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final inCart = HiveService.isInCart(product.id);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      Container(
                        width: double.infinity,
                        height: 300,
                        color: const Color(0xFFF8F8F8),
                        child: Center(
                          child: Hero(
                            tag: 'product-${product.id}',
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Image.network(
                                product.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2D3436),
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Price
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "₹${product.price}",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Divider
                            const Divider(color: Color(0xFFF0F0F0), height: 1),

                            const SizedBox(height: 20),

                            // Description
                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2D3436),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.description,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.7,
                                color: Color(0xFF636E72),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Add to Cart bar
              Container(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF636E72),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "₹${product.price}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2D3436),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),

                      // Add to Cart button
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.read<ProductBloc>().add(
                                ToggleCartEvent(product.id),
                              );
                            },
                            icon: Icon(
                              inCart
                                  ? Icons.check_rounded
                                  : Icons.shopping_bag_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            label: Text(
                              inCart ? "Added to Cart" : "Add to Cart",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: inCart
                                  ? const Color(0xFF00B894)
                                  : const Color(0xFF2D3436),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
