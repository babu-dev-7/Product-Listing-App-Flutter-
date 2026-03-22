import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/hive/hive_service.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<ProductBloc>().state is! ProductLoaded) {
      context.read<ProductBloc>().add(FetchProducts());
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Shop"),
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
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C5CE7)),
            );
          }

          if (state is ProductLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final p = state.products[index];
                final isFav = HiveService.isFavorite(p.id);
                final inCart = HiveService.isInCart(p.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                    elevation: 0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<ProductBloc>(),
                              child: ProductDetailPage(product: p),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFF0F0F0),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Product Image
                            Container(
                              width: 85,
                              height: 85,
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

                            // Title + Price + Add to Cart
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title row with heart
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
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
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () {
                                          context.read<ProductBloc>().add(
                                            ToggleFavoriteEvent(p.id),
                                          );
                                        },
                                        child: Icon(
                                          isFav
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_outline_rounded,
                                          color: isFav
                                              ? const Color(0xFFE84393)
                                              : const Color(0xFFCCCCCC),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // Price + Add to Cart row
                                  Row(
                                    children: [
                                      Text(
                                        "₹${p.price}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF2D3436),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 32,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            context.read<ProductBloc>().add(
                                              ToggleCartEvent(p.id),
                                            );
                                          },
                                          icon: Icon(
                                            inCart
                                                ? Icons.check_rounded
                                                : Icons.add_shopping_cart_rounded,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            inCart ? "Added" : "Add",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: inCart
                                                ? const Color(0xFF00B894)
                                                : const Color(0xFF0984E3),
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off_rounded,
                  size: 64,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
