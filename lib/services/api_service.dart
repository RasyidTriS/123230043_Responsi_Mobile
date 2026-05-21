import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latihan_responsi/models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http
        .get(Uri.parse(_baseUrl))
        .timeout(const Duration(seconds: 12));

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat produk');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw Exception('Format data produk tidak sesuai');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Product.fromJson)
        .toList();
  }

  Future<Product> fetchProductDetail(int id) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/$id'))
        .timeout(const Duration(seconds: 12));

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat detail produk');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Format detail produk tidak sesuai');
    }

    return Product.fromJson(decoded);
  }
}
