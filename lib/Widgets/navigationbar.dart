import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<NavigationProvider>(
          builder: (context, navigationProvider, child) {
            return _buildPage(navigationProvider.selectedIndex);
          },
        ),
      ),
      bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          return BottomNavigationBar(
            currentIndex: navigationProvider.selectedIndex,
            onTap: (index) {
              navigationProvider.setIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Product',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Customers',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return Center(
          child: Text('Home Page'),
        );
      case 1:
        return Center(
          child: Text('Product Page'),
        );
      case 2:
        return Center(
          child: Text('Customer Page'),
        );
      default:
        return Center(
          child: Text('Unknown Page'),
        );
    }
  }
}
