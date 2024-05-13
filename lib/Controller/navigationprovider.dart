import 'package:flutter/material.dart';
import 'package:req/Models/viewmodel.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  // Other methods and properties...
}
