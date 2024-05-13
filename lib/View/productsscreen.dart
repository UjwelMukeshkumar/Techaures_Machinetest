import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/Controller/Api%20Service.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.products.isEmpty) {
      productProvider.fetchProducts().catchError((error) {
        // Handle error
        print('Error fetching products: $error');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
      ),
      body: productProvider.products.isEmpty
          ? CircularProgressIndicator()
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
                return GridTile(
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            productProvider.products[index].image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Placeholder(); // Placeholder widget or error message
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productProvider.products[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Price: \$${productProvider.products[index].price}',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
