import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solulab5/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_event.dart';
import 'package:solulab5/blocs/product_bloc/product_state.dart';
import 'package:solulab5/models/product.dart';
import 'package:solulab5/widgets/common_widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: BlocSelector<ProductBloc, ProductState, List<Product>>(
        selector: (state) {
          if (state is ProductLoaded) {
            return state.products.where((product) => product.isInCart).toList();
          }
          return [];
        },
        builder: (context, cartProducts) {
          if (cartProducts.isEmpty) {
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
                        text: 'Shopping',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF101817),
                      ),
                      customDeleteButton(onPressed: () {
                        context.read<ProductBloc>().add(ClearCart());
                      }),
                    ],
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Your cart is empty.'),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              text: 'Shopping',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF101817),
                            ),
                            customDeleteButton(onPressed: () {
                              context.read<ProductBloc>().add(ClearCart());
                            }),
                          ],
                        ),
                        const SizedBox(height: 24.0),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartProducts.length,
                          itemBuilder: (context, index) {
                            final product = cartProducts[index];
                            final imageUrl = context
                                .read<ProductBloc>()
                                .imageUrls[cartProducts
                                    .indexOf(product) %
                                context.read<ProductBloc>().imageUrls.length];

                            return _buildCartItem(
                              product: product,
                              imageUrl: imageUrl,
                              onRemove: () {
                                context.read<ProductBloc>().add(
                                      ToggleCartProduct(product: product),
                                    );
                              },
                              onQuantityChange: (quantity) {
                                context.read<ProductBloc>().add(
                                      UpdateCartQuantity(
                                        product: product,
                                        quantity: quantity,
                                      ),
                                    );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildOrderSummary(cartProducts),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem({
    required Product product,
    required String imageUrl,
    required VoidCallback onRemove,
    required Function(int) onQuantityChange,
  }) {
    return Card(
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            SizedBox(
              height: 72,
              width: 72,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSwitzerText(
                    text: product.title,
                    maxLines: 1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF101817),
                  ),
                  const SizedBox(height: 2.0),
                  customSwitzerText(
                    text: product.description ?? 'Brand',
                    maxLines: 1,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF828A89),
                  ),
                  const SizedBox(height: 12.0),
                  customSwitzerText(
                    text: '\$${product.price.toStringAsFixed(2)}',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF2A666),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (product.quantity > 1) {
                      onQuantityChange(product.quantity - 1);
                    } else {
                      onRemove();
                    }
                  },
                  icon: SvgPicture.asset('assets/images/svg/minus.svg'),
                ),
                const SizedBox(width: 8.0),
                customSwitzerText(
                  text: product.quantity.toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF101817),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  onPressed: () {
                    onQuantityChange(product.quantity + 1);
                  },
                  icon: SvgPicture.asset('assets/images/svg/plus.svg'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(List<Product> cartProducts) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSwitzerText(
            text: 'Order Summary',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF101817),
          ),
          const SizedBox(height: 16.0),
          _buildSummaryItem(
            label: 'Subtotal',
            value: _calculateSubtotal(cartProducts),
          ),
          const SizedBox(height: 8.0),
          _buildSummaryItem(
            label: 'Shipping Cost',
            value: '\$26.00',
          ),
          const SizedBox(height: 20.0),
          _buildSummaryItem(
            label: 'Total Payment',
            colorL: const Color(0xFF101817),
            value: _calculateTotal(cartProducts),
            fontWeight: FontWeight.w600,
            fontWeightV: FontWeight.w600,
          ),
          const SizedBox(height: 32.0),
          SizedBox(
            width: double.infinity,
            child: customButton(
              text: 'Check Out',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required String label,
    required String value,
    FontWeight fontWeight = FontWeight.w400,
    FontWeight fontWeightV = FontWeight.w500,
    colorL = const Color(0xFF828A89),
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customSwitzerText(
          text: label,
          fontSize: 16,
          fontWeight: fontWeight,
          color: colorL,
        ),
        customSwitzerText(
          text: value,
          fontSize: 16,
          fontWeight: fontWeightV,
          color: const Color(0xFFF2A666),
        ),
      ],
    );
  }

  String _calculateSubtotal(List<Product> cartProducts) {
    double subtotal = 0;
    for (final product in cartProducts) {
      subtotal += product.price * product.quantity;
    }
    return '\$${subtotal.toStringAsFixed(2)}';
  }

  String _calculateTotal(List<Product> cartProducts) {
    double total = 0;
    for (final product in cartProducts) {
      total += product.price * product.quantity;
    }
    total += 26.00;
    return '\$${total.toStringAsFixed(2)}';
  }
}
