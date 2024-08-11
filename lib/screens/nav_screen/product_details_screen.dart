import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solulab5/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_event.dart';
import 'package:solulab5/blocs/product_bloc/product_state.dart';
import 'package:solulab5/models/product.dart';
import 'package:solulab5/widgets/common_widgets.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final String imageUrl;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoaded) {
              final currentProduct = state.products.firstWhere(
                (p) => p.id == product.id,
                orElse: () => product,
              );

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customBackButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<ProductBloc>().add(
                                          ToggleFavoriteProduct(
                                              product: currentProduct),
                                        );

                                    if (currentProduct.isFavorite) {
                                      context
                                          .read<NavigationBloc>()
                                          .add(NavigationEvent.favorite);
                                    }
                                  },
                                  icon: Icon(
                                    currentProduct.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: currentProduct.isFavorite
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Center(
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  SizedBox(
                                    height: 250.0,
                                    child: SvgPicture.asset(
                                        'assets/images/svg/3d_view.svg'),
                                  ),
                                  Positioned(
                                    height: 210,
                                    top: -50,
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: SizedBox(
                              height: 64.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 270.0,
                                    child: customSwitzerText(
                                      text: currentProduct.title,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF101817),
                                    ),
                                  ),
                                  customSwitzerText(
                                    text: '\$${currentProduct.price}',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFF2A666),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 22.0,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/svg/people.svg'),
                                          const SizedBox(width: 4.0),
                                          customSwitzerText(
                                            text: '341 Seen',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF828A89),
                                          ),
                                          const SizedBox(width: 8.0),
                                          SvgPicture.asset(
                                              'assets/images/svg/favourite.svg'),
                                          const SizedBox(width: 4.0),
                                          customSwitzerText(
                                            text: '294 Liked',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF828A89),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/svg/rating.svg'),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 83.0),
                                SizedBox(
                                    height: 30,
                                    width: 71,
                                    child: Image.asset(
                                        'assets/images/people_review.png')),
                              ],
                            ),
                          ),
                          const SizedBox(height: 21.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: customSwitzerText(
                              text: 'Description',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF101817),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: SizedBox(
                              height: 66.0,
                              child: customSwitzerText(
                                text: currentProduct.description ??
                                    'No description available',
                                maxLines: 3,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF828A89),
                              ),
                            ),
                          ),
                          const SizedBox(height: 21.0),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 154.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (currentProduct.quantity > 1) {
                                        context.read<ProductBloc>().add(
                                              UpdateCartQuantity(
                                                product: currentProduct,
                                                quantity:
                                                    currentProduct.quantity - 1,
                                              ),
                                            );
                                      }
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/images/svg/minus.svg'),
                                  ),
                                  customSwitzerText(
                                    text: currentProduct.quantity.toString(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF828A89),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.read<ProductBloc>().add(
                                            UpdateCartQuantity(
                                              product: currentProduct,
                                              quantity:
                                                  currentProduct.quantity + 1,
                                            ),
                                          );
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/images/svg/plus.svg'),
                                  ),
                                ],
                              ),
                              customSwitzerText(
                                text:
                                    'Total : \$${(currentProduct.price * currentProduct.quantity).toStringAsFixed(2)}',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF101817),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: BlocBuilder<ProductBloc, ProductState>(
                              builder: (context, state) {
                                if (state is ProductLoaded) {
                                  final isInCart = state.products.any(
                                      (p) => p.id == product.id && p.isInCart);

                                  return customButtonwithImage(
                                      text: isInCart
                                          ? 'Added to Cart'
                                          : 'Add To Cart',
                                      onPressed: () {
                                        context.read<ProductBloc>().add(
                                              ToggleCartProduct(
                                                  product: currentProduct),
                                            );
                                      },
                                      imagePath: 'assets/images/svg/cart1.svg');
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
