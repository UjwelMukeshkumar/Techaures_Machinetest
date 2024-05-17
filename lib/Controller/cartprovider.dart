import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:req/Models/viewmodel.dart';
import 'package:req/database.dart';

class Cart extends ChangeNotifier {
  final List<CartProduct> _list = [];
  List<Products> items = [];
  List<CartProduct> get getItems {
    return _list;
  }

  void addItem1(
      int id, String name, double price, int quantity, String image) async {
    final cartItem = {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
    DBHelper.instance.insertCartItem(cartItem);
    log("Item added to cart and stored locally in the database.");
    notifyListeners();
  }

  bool containsProduct(Products product) {
    return items.any((item) => item.name == product.name);
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      if (item.qty > 0) {
        // Check if quantity is greater than 0
        total += item.price * item.qty;
      }
    }
    return total;
  }

  int? get count {
    return _list.length;
  }

  void addItem(
    int id,
    String name,
    double price,
    int qty,
    String image,
  ) {
    final product = CartProduct(
      id: id,
      name: name,
      price: price,
      qty: qty,
      imagesUrl: image,
    );
    _list.add(product);
    notifyListeners();
    log("add product  !!!!!!!!!!!!!!!");
  }

  int countOf(int id) {
    // Count the occurrences of the item with the specified ID
    return _list.where((item) => item.id == id).length;
  }

  CartProduct? getItem(int id) {
    // Find the CartProduct with the specified ID
    return _list.firstWhere(
      (item) => item.id == id,
    );
  }

  void increment(CartProduct product) {
    product.increase();
    notifyListeners();
  }

  void reduceByOne(CartProduct product) {
    if (product.qty > 0) {
      // Check if quantity is greater than 0
      product.decrease();
      notifyListeners();
    }
  }

  void removeItem(CartProduct product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}

class CartProduct {
  int id;
  String name;
  double price;
  int qty = 1;
  String imagesUrl;

  CartProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.imagesUrl,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        imagesUrl: json["image"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": imagesUrl,
        "qty": qty,
      };
  void increase() {
    qty++;
    qty = qty++;
  }

  void decrease() {
    qty--;
    qty = qty - 1;
  }
}
