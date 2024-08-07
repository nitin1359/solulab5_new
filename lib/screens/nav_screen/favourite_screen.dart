import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solulab5/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_event.dart';
import 'package:solulab5/blocs/product_bloc/product_state.dart';
import 'package:solulab5/widgets/common_widgets.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductLoaded) {}
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoaded) {
              final favoriteProducts = state.products
                  .where((product) => product.isFavorite)
                  .toList();

              if (favoriteProducts.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBackButton(
                            onPressed: () {
                              context
                                  .read<NavigationBloc>()
                                  .add(NavigationEvent.home);
                            },
                          ),
                          customSwitzerText(
                            text: 'Favourite',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF101817),
                          ),
                          customFavouriteButton(onPressed: () {}),
                        ],
                      ),
                      const Expanded(
                        child: Center(
                          child: Text('No favorite items yet.'),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customBackButton(
                          onPressed: () {
                            context
                                .read<NavigationBloc>()
                                .add(NavigationEvent.home);
                          },
                        ),
                        customSwitzerText(
                          text: 'Favourite',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF101817),
                        ),
                        customFavouriteButton(onPressed: () {}),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final product = favoriteProducts[index];
                          final imageUrl = context
                                  .read<ProductBloc>()
                                  .imageUrls[
                              favoriteProducts.indexOf(product) %
                                  context.read<ProductBloc>().imageUrls.length];

                          return Card(
                            elevation: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 112,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: const Color(0xFFFFFFFF),
                                        ),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: IconButton(
                                          onPressed: () {
                                            context.read<ProductBloc>().add(
                                                  ToggleFavoriteProduct(
                                                      product: product),
                                                );
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: product.isFavorite
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  customSwitzerText(
                                    text: product.title,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF101817),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      customSwitzerText(
                                        text: '\$${product.price}',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFF2A666),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
