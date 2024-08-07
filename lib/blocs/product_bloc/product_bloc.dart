import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solulab5/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final List<String> imageUrls = [
    'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
    'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg',
    'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
    'https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg',
    'https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg',
    'https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg',
    'https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg',
    'https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg',
    'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg',
    'https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg',
    'https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg',
    'https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',
  ];

  ProductBloc({required this.productRepository}) : super(ProductLoading()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchProducts();
        final prefs = await SharedPreferences.getInstance();

        final favoriteIds = prefs.getStringList('favoriteIds') ?? [];
        final cartIds = prefs.getStringList('cartIds') ?? [];

        final updatedProducts = products.map((product) {
          product.isFavorite = favoriteIds.contains(product.id);
          product.isInCart = cartIds.contains(product.id);
          return product;
        }).toList();

        emit(ProductLoaded(updatedProducts, imageUrls));
      } catch (e) {
        if (kDebugMode) {
          print('Bloc Error: $e');
        }
        emit(ProductError(e.toString()));
      }
    });

    on<ToggleFavoriteProduct>((event, emit) async {
      if (state is ProductLoaded) {
        final loadedState = state as ProductLoaded; 

        final updatedProducts = loadedState.products.map((product) {
          if (product.id == event.product.id) {
            return product.copyWith(isFavorite: !product.isFavorite);
          } else {
            return product;
          }
        }).toList();

        final prefs = await SharedPreferences.getInstance();
        final favoriteIds = prefs.getStringList('favoriteIds') ?? [];
        if (event.product.isFavorite) {
          favoriteIds.remove(event.product.id);
        } else {
          favoriteIds.add(event.product.id);
        }
        await prefs.setStringList('favoriteIds', favoriteIds);

        emit(ProductLoaded(updatedProducts, loadedState.imageUrls));
      }
    });

    on<ToggleCartProduct>((event, emit) async {
      if (state is ProductLoaded) {
        final loadedState = state as ProductLoaded;

        final updatedProducts = loadedState.products.map((product) {
          if (product.id == event.product.id) {
            return product.copyWith(isInCart: !product.isInCart);
          } else {
            return product;
          }
        }).toList();

        final prefs = await SharedPreferences.getInstance();
        final cartIds = prefs.getStringList('cartIds') ?? [];
        if (event.product.isInCart) {
          cartIds.remove(event.product.id);
        } else {
          cartIds.add(event.product.id);
        }
        await prefs.setStringList('cartIds', cartIds);

        emit(ProductLoaded(updatedProducts, loadedState.imageUrls));
      }
    });

    on<UpdateCartQuantity>((event, emit) {
      if (state is ProductLoaded) {
        final loadedState = state as ProductLoaded;

        final updatedProducts = loadedState.products.map((product) {
          if (product.id == event.product.id) {
            return product.copyWith(quantity: event.quantity);
          } else {
            return product;
          }
        }).toList();
        emit(ProductLoaded(updatedProducts, loadedState.imageUrls));
      }
    });

    on<ClearCart>((event, emit) {
      if (state is ProductLoaded) {
        final loadedState = state as ProductLoaded;

        final updatedProducts = loadedState.products
            .map((product) => product.copyWith(isInCart: false, quantity: 1))
            .toList();
        emit(ProductLoaded(updatedProducts, loadedState.imageUrls));
      }
    });
  }
}