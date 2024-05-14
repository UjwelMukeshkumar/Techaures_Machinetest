import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:req/View/HomeScreen.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<dynamic> customers = [];

  Future<void> fetchCustomers() async {
    final response =
        await http.get(Uri.parse('http://143.198.61.94:8000/api/customers/'));
    if (response.statusCode == 200) {
      setState(() {
        customers = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load customers');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers', textAlign: TextAlign.center),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductListView()));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context, int index) {
          final customer = customers[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'http://143.198.61.94:8000${customer['profile_pic']}'),
              ),
              title: Text(customer['name']),
              subtitle: Text(customer['email']),
              onTap: () {
                // Navigate to customer details screen
                // You can pass customer data to the next screen if needed
              },
            ),
          );
        },
      ),
    );
  }
}
