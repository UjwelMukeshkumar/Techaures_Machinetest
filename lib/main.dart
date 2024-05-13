import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/Controller/Api%20Service.dart';
import 'package:req/View/HomeScreen.dart';
import 'package:req/View/productsscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // Assuming ViewController is your state management provider
          ChangeNotifierProvider(create: (_) => ProductProvider()),

          // Add more providers if needed
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Product App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Product()));
  }
}
