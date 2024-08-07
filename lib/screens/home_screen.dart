import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solulab5/blocs/banner_bloc/banner_bloc.dart';
import 'package:solulab5/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_bloc.dart';
import 'package:solulab5/blocs/product_bloc/product_event.dart';
import 'package:solulab5/blocs/product_bloc/product_state.dart';
import 'package:solulab5/models/product.dart';
import 'package:solulab5/repositories/product_repository.dart';
import 'package:solulab5/screens/banner_section.dart';
import 'package:solulab5/screens/nav_screen/all_products.dart';
import 'package:solulab5/screens/nav_screen/cart_screen.dart';
import 'package:solulab5/screens/nav_screen/favourite_screen.dart';
import 'package:solulab5/screens/nav_screen/product_details_screen.dart';
import 'package:solulab5/screens/nav_screen/profile_screen.dart';
import 'package:solulab5/widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: ProductRepository())
        ..add(LoadProducts()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SafeArea(
          child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _pageController.jumpToPage(_getCurrentIndex(state));
              });

              return PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  context
                      .read<NavigationBloc>()
                      .add(NavigationEvent.values[index]);
                },
                children: const [
                  HomeScreenContent(),
                  FavoriteScreen(),
                  CartScreen(),
                  ProfileScreen(),
                ],
              );
            },
          ),
        ),
        floatingActionButton: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationCart || state is NavigationProfile) {
              return const SizedBox.shrink(); 
            } else {
              return Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: const Color(0xFF0C8A7B),
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(
                    'assets/images/svg/eye_scanner.svg',
                    height: 24,
                    width: 24,
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationCart || state is NavigationProfile) {
              return const SizedBox.shrink();
            } else {
              return BottomAppBar(
                color: const Color(0xFFF9F9F9),
                shape: const CircularNotchedRectangle(),
                notchMargin: 8.0,
                child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildNavItem('assets/images/svg/bottom_nav_home.svg',
                          'Home', 0, state, context),
                      _buildNavItem('assets/images/svg/bottom_nav_favourite.svg',
                          'Favourite', 1, state, context),
                      const SizedBox(width: 40), 
                      _buildNavItem('assets/images/svg/bottom_nav_cart.svg',
                          'Shopping', 2, state, context),
                      _buildNavItem('assets/images/svg/bottom_nav_profile.svg',
                          'Profile', 3, state, context),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgPath, String label, int index,
      NavigationState state, BuildContext context) {
    final isSelected = _getCurrentIndex(state) == index;
    return InkWell(
      onTap: () {
        context.read<NavigationBloc>().add(NavigationEvent.values[index]);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? const Color(0xFF0C8A7B) : const Color(0xFF828A89),
              BlendMode.srcIn,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF0C8A7B)
                  : const Color(0xFF828A89),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(NavigationState state) {
    if (state is NavigationHome) {
      return 0;
    } else if (state is NavigationFavorite) {
      return 1;
    } else if (state is NavigationCart) {
      return 2;
    } else if (state is NavigationProfile) {
      return 3;
    }
    return 0;
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerBloc(),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            final imageUrls = state.imageUrls;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                child: CircleAvatar(
                                  foregroundImage: AssetImage(
                                    'assets/images/profile_image.png',
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customSwitzerText(
                                    text: 'Welcome,',
                                    fontSize: 13,
                                    color: const Color(0xFF828A89),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  customSwitzerText(
                                    text: 'Besnik Doe',
                                    fontSize: 16,
                                    color: const Color(0xFF101817),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )
                            ],
                          ),
                          customNotificationButton(onPressed: () {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    SizedBox(
                      height: 48.0,
                      child: TextFormField(
                        obscureText: false,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search Furniture',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF828A89),
                            fontFamily: 'Switzer',
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/images/svg/search_lens.svg',
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                                'assets/images/svg/filter_button.svg'),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24.0),
                    customSwitzerText(
                      text: 'Special Offers',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF101817),
                    ),

                    const SizedBox(height: 16.0),

                    const BannerSection(),

                    const SizedBox(height: 24.0),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          categoryButton(
                            index: 0,
                            svgAsset: 'assets/images/svg/filter_icon1.svg',
                            text: 'Armchair',
                            onPressed: () {},
                          ),
                          categoryButton(
                            index: 1,
                            svgAsset: 'assets/images/svg/filter_icon2.svg',
                            text: 'Sofa',
                            onPressed: () {},
                          ),
                          categoryButton(
                            index: 2,
                            svgAsset: 'assets/images/svg/filter_icon3.svg',
                            text: 'Bed',
                            onPressed: () {},
                          ),
                          categoryButton(
                            index: 3,
                            svgAsset: 'assets/images/svg/filter_icon4.svg',
                            text: 'Light',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12.0),

                    _buildProductSection(
                      title: 'Most Interested',
                      products: products
                          .where((product) =>
                              product.category.name == 'men\'s fashion')
                          .map((product) => _buildProductCard(
                                product: product,
                                imageUrl: imageUrls[products.indexOf(product) %
                                    imageUrls.length],
                              ))
                          .toList(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductsScreen(
                              products: products,
                              imageUrls: imageUrls,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                    _buildProductSection2(
                      title: 'Popular',
                      products: products
                          .where(
                              (product) => product.category.name == 'computers')
                          .map((product) => _buildProductCard2(
                                product: product,
                                imageUrl: imageUrls[products.indexOf(product) %
                                    imageUrls.length],
                              ))
                          .toList(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductsScreen(
                              products: products,
                              imageUrls: imageUrls,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                    _buildProductSection(
                      title: 'Women\'s Fashion',
                      products: products
                          .where((product) =>
                              product.category.name == 'women\'s fashion')
                          .map((product) => _buildProductCard(
                                product: product,
                                imageUrl: imageUrls[products.indexOf(product) %
                                    imageUrls.length],
                              ))
                          .toList(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductsScreen(
                              products: products,
                              imageUrls: imageUrls,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),

                    _buildProductSection(
                      title: 'Home & furniture',
                      products: products
                          .where((product) =>
                              product.category.name == 'home & furniture')
                          .map((product) => _buildProductCard(
                                product: product,
                                imageUrl: imageUrls[products.indexOf(product) %
                                    imageUrls.length],
                              ))
                          .toList(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductsScreen(
                              products: products,
                              imageUrls: imageUrls,
                            ),
                          ),
                        );
                      },
                    ),
                    // Add more categories here
                  ],
                ),
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProductSection(
      {required String title,
      required List<Widget> products,
      required VoidCallback? onPressed}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customSwitzerText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF101817),
            ),
            TextButton(
              onPressed: onPressed,
              child: customSwitzerText(
                text: 'View All',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFF2A666),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 211.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: products,
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
      {required Product product, required String imageUrl}) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  product: product,
                  imageUrl: imageUrl,
                ),
              ),
            );
          },
          child: Positioned(
            child: Container(
              width: 211,
              height: 254,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        imageUrl,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 46,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 118,
                            child: customSwitzerText(
                              text: product.title,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF101817),
                            ),
                          ),
                          const Expanded(child: SizedBox.shrink()),
                          Align(
                            alignment: Alignment.center,
                            child: BlocBuilder<ProductBloc, ProductState>(
                              builder: (context, state) {
                                if (state is ProductLoaded) {
                                  final isInCart = state.products
                                      .any((p) => p.id == product.id && p.isInCart);
            
                                  return IconButton(
                                    onPressed: () {
                                      context.read<ProductBloc>().add(
                                            ToggleCartProduct(product: product),
                                          );
                                    },
                                    icon: SvgPicture.asset(
                                      isInCart
                                          ? 'assets/images/svg/cart_image.svg'
                                          : 'assets/images/svg/cart_image1.svg',
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    customSwitzerText(
                      text: '\$${product.price}',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFF2A666),
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

  

  Widget _buildProductSection2(
      {required String title,
      required List<Widget> products,
      required VoidCallback? onPressed}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customSwitzerText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF101817),
            ),
            TextButton(
              onPressed: onPressed,
              child: customSwitzerText(
                text: 'View All',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFF2A666),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 104.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: products,
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard2(
      {required Product product, required String imageUrl}) {
    return Container(
      width: 226,
      height: 104,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: const Color(0xFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0xFFF0F0F2),
              ),
              child: Image.network(
                imageUrl,
                height: 45,
                width: 45,
                fit: BoxFit.cover,
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            SizedBox(
              width: 110,
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSwitzerText(
                    text: product.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF101817),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  customSwitzerText(
                    text: '\$${product.price}',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF2A666),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}