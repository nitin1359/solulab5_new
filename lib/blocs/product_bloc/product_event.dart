import 'package:solulab5/models/product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class ToggleFavoriteProduct extends ProductEvent {
  final Product product;

  ToggleFavoriteProduct({required this.product});
}

class ToggleCartProduct extends ProductEvent {
  final Product product;

  ToggleCartProduct({required this.product});
}

class UpdateCartQuantity extends ProductEvent {
  final Product product;
  final int quantity;

  UpdateCartQuantity({required this.product, required this.quantity});
}

class ClearCart extends ProductEvent {}