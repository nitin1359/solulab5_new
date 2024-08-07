import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:solulab5/models/product.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('https://api.storerestapi.com/products');
      if (response.statusCode == 200) {
        print('Response Data: ${response.data}');
        List<Product> products = (response.data['data'] as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        print('Products: $products');
        return products;
      } else {
        throw Exception('Failed to load products with status code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      throw Exception('Failed to load products');
    }
  }
}
