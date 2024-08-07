import 'package:solulab5/models/product.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<String> imageUrls;

  ProductLoaded(this.products, this.imageUrls);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}