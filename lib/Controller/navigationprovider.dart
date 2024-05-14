import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners(); // Notify listeners that the state has changed
  }
}
