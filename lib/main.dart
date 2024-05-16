import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/Controller/Api%20Service.dart';
import 'package:req/Controller/cartprovider.dart';

import 'package:req/View/HomeScreen.dart';

import 'package:req/Widgets/navigationbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ChangeNotifierProvider(create: (_) => ProductController()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen()));
  }
}
