import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:req/Models/viewmodel.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  get selectedIndex => null;

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://143.198.61.94:8000/api/products/'));

      if (response.statusCode == 200) {
        List<Product> fetchedProducts = [];
        var jsonResponse = json.decode(response.body);
        for (var item in jsonResponse['data']) {
          fetchedProducts.add(Product.fromJson(item));
        }
        _products = fetchedProducts;
        print('Products fetched: $_products'); // Debugging
        notifyListeners();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching products: $error'); // Debugging
      throw Exception('Failed to load products: $error');
    }
  }

  void changeSelectedIndex(int index) {}
}
