// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:provider_course/prodivder/product_provider.dart';
// import 'package:provider_course/screens/new_product_screen.dart';
// import 'package:provider_course/screens/product_screen.dart';
// import 'package:provider_course/screens/promo_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);

//   final productProvider = ProductProvider();

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ProductProvider(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const ProductScreen(),
//         routes: {
//           '/new': (context) => const NewProductScreen(),
//           '/promo': (context) => const PromoScreen(),
//         },
//       ),
//     );
//   }
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_course/prodivder/product_provider.dart';
import 'package:provider_course/screens/new_product_screen.dart';
import 'package:provider_course/screens/product_screen.dart';
import 'package:provider_course/screens/promo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _productProvider = ProductProvider();
  final _productProvider2 = ProductProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider.value(
          value: _productProvider, child: const ProductScreen()),
      routes: {
        '/new': (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: _productProvider),
                ChangeNotifierProvider(
                  create: (_) => ProductProvider(),
                )
              ],
              child: const NewProductScreen(),
            ),
        '/promo': (context) => ChangeNotifierProvider.value(
              value: _productProvider2,
              child: const PromoScreen(),
            ),
      },
    );
  }
}
