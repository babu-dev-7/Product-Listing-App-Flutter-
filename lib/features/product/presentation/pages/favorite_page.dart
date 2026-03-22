import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/hive/hive_service.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Wishlist"),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2D3436),
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Color(0xFF2D3436),
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFEEEEEE),
            height: 1,
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            final favProducts = state.products
                .where((p) => HiveService.isFavorite(p.id))
                .toList();

            if (favProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_outline_rounded,
                      size: 72,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Your wishlist is empty",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Save items you love by tapping the ♡",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              itemCount: favProducts.length,
              itemBuilder: (context, i) {
                final p = favProducts[i];
                final inCart = HiveService.isInCart(p.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFF0F0F0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Image
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.network(
                                p.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        // Title + Price + Move to Cart
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF2D3436),
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    "₹${p.price}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF2D3436),
                                    ),
                                  ),
                                  const Spacer(),
                                  // Move to cart
                                  SizedBox(
                                    height: 30,
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        context.read<ProductBloc>().add(
                                          ToggleCartEvent(p.id),
                                        );
                                      },
                                      icon: Icon(
                                        inCart
                                            ? Icons.check_rounded
                                            : Icons.shopping_bag_outlined,
                                        size: 14,
                                        color: inCart
                                            ? const Color(0xFF00B894)
                                            : const Color(0xFF0984E3),
                                      ),
                                      label: Text(
                                        inCart ? "In Cart" : "Move to Cart",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: inCart
                                              ? const Color(0xFF00B894)
                                              : const Color(0xFF0984E3),
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        side: BorderSide(
                                          color: inCart
                                              ? const Color(0xFF00B894)
                                              : const Color(0xFF0984E3),
                                          width: 1.2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Remove from wishlist
                        GestureDetector(
                          onTap: () {
                            context.read<ProductBloc>().add(
                              ToggleFavoriteEvent(p.id),
                            );
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: Color(0xFFB2BEC3),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFE84393),
            ),
          );
        },
      ),
    );
  }
}