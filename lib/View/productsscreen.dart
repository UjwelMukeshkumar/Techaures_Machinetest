import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/Controller/Api%20Service.dart';
import 'package:req/View/HomeScreen.dart';
import 'package:req/View/cartpage.dart';

import 'package:req/View/detailpage.dart';

class Product extends StatelessWidget {
  const Product({Key? key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductController>(context);

    if (productProvider.products.isEmpty) {
      productProvider.fetchProducts().catchError((error) {
        // Handle error
        print('Error fetching products: $error');
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            kToolbarHeight + 10.0), // Adjust height as needed
        child: AppBar(
          title: const Text('Fruits', textAlign: TextAlign.center),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductListView()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                // Navigate to cart page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ],
        ),
      ),
      body: productProvider.products.isEmpty
          ? const CircularProgressIndicator()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio:
                    0.75, // Aspect ratio (width / height) of each item
              ),
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product =
                    productProvider.products[index]; // Get the current product
                return GestureDetector(
                  onTap: () {
                    // Navigate to product detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: productProvider.products[index],
                        ), // Pass the current product
                      ),
                    );
                  },
                  child: GridTile(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.network(
                                'http://143.198.61.94:8000${product.image}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Price: \$${product.price}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
