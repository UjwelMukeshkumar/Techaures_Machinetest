import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/Controller/Api%20Service.dart';
import 'package:req/Controller/cartprovider.dart';
import 'package:req/View/Customer.dart';
import 'package:req/View/HomeScreen.dart';
import 'package:req/View/cartpage.dart';
import 'package:req/View/detailpage.dart';
import 'package:req/color.dart';

class Product extends StatelessWidget {
  const Product({Key? key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    final productProvider = Provider.of<ProductController>(context);

    if (productProvider.products.isEmpty) {
      productProvider.fetchProducts().catchError((error) {
        // Handle error
        print('Error fetching products: $error');
      });
    }
    int totalItemsInCart = cartProvider.getItems.fold(
      0,
      (previousValue, cartProduct) => previousValue + cartProduct.qty,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10.0),
        child: AppBar(
          title: const Text('Fruits', textAlign: TextAlign.center),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
          actions: <Widget>[
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
                if (totalItemsInCart > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        totalItemsInCart.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: productProvider.products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 600
                          ? 4
                          : MediaQuery.of(context).size.width > 400
                              ? 3
                              : 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: productProvider.products.length,
                    itemBuilder: (context, index) {
                      final product = productProvider.products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                      product: product,
                                    )),
                          );
                        },
                        child: GridTile(
                          child: Card(
                            color: AppColors.primaryColor,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text('Price: \$${product.price}'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cartProvider.addItem(
                                          product.id,
                                          product.name,
                                          double.parse(
                                              product.price.toString()),
                                          1,
                                          product.image,
                                        );
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                    Text('${cartProvider.countOf(product.id)}'),
                                    IconButton(
                                      onPressed: () {
                                        cartProvider.reduceByOne(
                                            cartProvider.getItem(product.id)!);
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 16.0, left: 10, right: 10), // Add bottom padding
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal: \n  \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to cart page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerListScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .green.shade300, // Specify the button color here
                    ),
                    child: Text(
                      'Checkout Now',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
