import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_event.dart';
import 'package:solulab5/blocs/product_bloc/product_state.dart';
import 'package:solulab5/models/product.dart';
import 'package:solulab5/widgets/common_widgets.dart';

class AllProductsScreen extends StatelessWidget {
  final List<Product> products;
  final List<String> imageUrls;

  const AllProductsScreen({
    super.key,
    required this.products,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 16,
            childAspectRatio: 0.6,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final imageUrl =
                imageUrls[products.indexOf(product) % imageUrls.length];

            return GestureDetector(
              onTap: () {},
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Center(
                        child: SizedBox(
                          height: 160,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            if (state is ProductLoaded) {
                              final isFavorite = state.products.any(
                                  (p) => p.id == product.id && p.isFavorite);
                              final isInCart = state.products
                                  .any((p) => p.id == product.id && p.isInCart);

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.read<ProductBloc>().add(
                                            ToggleFavoriteProduct(
                                                product: product),
                                          );
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          isFavorite ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                  customSwitzerText(
                                      text: '\$${product.price}',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFF2A666)),
                                  IconButton(
                                    onPressed: () {
                                      context.read<ProductBloc>().add(
                                            ToggleCartProduct(product: product),
                                          );
                                    },
                                    icon: Icon(
                                      isInCart
                                          ? Icons.shopping_cart
                                          : Icons.shopping_cart_outlined,
                                      color:
                                          isInCart ? Colors.blue : Colors.grey,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
