import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_course/models/product.dart';

import '../prodivder/product_provider.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  late final TextEditingController _controller;

  void _addProduct(String name) {
    final product = Product(name: name, price: 10000);
    final productProvider = context.read<ProductProvider>();
    productProvider.add(product);
    Navigator.of(context).pop();
  }

  void _navigateToPromo(BuildContext context) {
    Navigator.pushNamed(context, "/promo");
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Nhập tên sản phẩm!'),
          ),
          TextButton(
            onPressed: () {
              final text = _controller.text;
              if (text.isNotEmpty) {
                _addProduct(text);
              }
            },
            child: const Text('Add'),
          ),
          TextButton(
            onPressed: () {
              _navigateToPromo(context);
            },
            child: const Text('PROMO -------------'),
          )
        ],
      ),
    );
  }
}
