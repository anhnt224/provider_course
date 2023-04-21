// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_course/prodivder/product_provider.dart';
import 'package:provider_course/screens/new_product_screen.dart';
import 'package:provider_course/screens/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductScreen(),
        routes: {
          '/new': (context) => const NewProductScreen(),
        },
      ),
    );
  }
}
