import 'package:solulab5/models/product.dart';

class Category {
  final String name;
  final List<Product> products;

  Category({
    required this.name,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json['name'] as String,
        products: (json['products'] as List<dynamic>)
            .map((productJson) => Product.fromJson(productJson))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'products': products.map((product) => product.toJson()).toList(),
      };
}
