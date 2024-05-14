import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/Controller/cartprovider.dart';
import 'package:req/Models/viewmodel.dart'; // Import Product if it's defined here
import 'package:req/color.dart';

class ProductDetailPage extends StatelessWidget {
  final Products product;

  const ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'http://143.198.61.94:8000${product.image}',
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Text(
              'Name: ${product.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: \$${product.price}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                log("price == ${product.price}");

                var existingItemCart = context.read<Cart>();

                if (existingItemCart.containsProduct(product)) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    content: Text("This item already in cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ));
                } else {
                  context.read<Cart>().addItem(
                      product.id,
                      product.name,
                      double.parse(product.price.toString()),
                      1,
                      'http://143.198.61.94:8000${product.image}');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    content: Text("Added to cart !!!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ));
                }
              },
              child: Container(
                width: double.infinity,
                height: 57,
                decoration: BoxDecoration(
                    color: AppColors.FirstColor,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
