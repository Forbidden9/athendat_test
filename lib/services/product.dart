import 'dart:convert';
import 'package:athendat_test/models/product.dart';
import 'package:http/http.dart' as http;

class ProductApiAdapter {
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl?select=title,description,category,price,thumbnail'), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['products'];
      List<Product> products = body.map((item) => Product.fromJson(item)).take(10).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
