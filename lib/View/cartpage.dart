import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:req/Controller/cartprovider.dart';

import 'package:req/color.dart';
import 'package:req/database.dart';

class CartPage extends StatelessWidget {
  List<CartProduct> cartlist = [];

  Future<void> _createOrder(BuildContext context) async {
    const url = 'http://143.198.61.94:8000/api/orders/';
    final cart = context.read<Cart>();

    final requestData = {
      "customer_id": 2,
      "total_price": cart.totalPrice,
      "products": cart.getItems.map((product) {
        return {
          "product_id": product.id,
          "quantity": product.qty,
          "price": product.price
        };
      }).toList(),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Order placed successfully!"),
        ),
      );

      cart.clearCart();

      // Insert items into local database
      for (var item in cart.getItems) {
        CartDatabaseHelper.instance.insert({
          CartDatabaseHelper.columnName: item.name,
          CartDatabaseHelper.columnPrice: item.price,
          CartDatabaseHelper.columnQuantity: item.qty,
          CartDatabaseHelper.columnImageUrl: item.imagesUrl,
        });
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to place order. Please try again."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Cart",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        actions: [
          context.watch<Cart>().getItems.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    context.read<Cart>().clearCart();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 56, 55, 55),
                  )),
        ],
      ),
      body: context.watch<Cart>().getItems.isEmpty
          ? const Center(
              child: Text("Empty Cart"),
            )
          : Consumer<Cart>(builder: (context, cart, child) {
              cartlist = cart.getItems;
              return ListView.builder(
                itemCount: cart.count,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'http://143.198.61.94:8000${cartlist[index].imagesUrl}',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cartlist[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(97, 97, 97, 1),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            cartlist[index].price.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red.shade900,
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    cartlist[index].qty == 1
                                                        ? cart.removeItem(
                                                            cartlist[index])
                                                        : cart.reduceByOne(
                                                            cartlist[index]);
                                                  },
                                                  icon: cartlist[index].qty == 1
                                                      ? const Icon(
                                                          Icons.delete,
                                                          size: 18,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .minimize_rounded,
                                                          size: 18,
                                                        ),
                                                ),
                                                Text(
                                                  cartlist[index]
                                                      .qty
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.red.shade900,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    cart.increment(
                                                        cartlist[index]);
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total : ${context.watch<Cart>().totalPrice}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                if (context.read<Cart>().getItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: Text(
                        "Cart is empty !!!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                } else {
                  _createOrder(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Text(
                      "CheckOut Now",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
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
