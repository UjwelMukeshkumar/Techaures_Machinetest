import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:req/Models/viewmodel.dart';

class ProductController extends ChangeNotifier {
  List<Products> products = [];

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://143.198.61.94:8000/api/products/'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      products = (jsonData['data'] as List)
          .map((item) => Products.fromJson(item))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
