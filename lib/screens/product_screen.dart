import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../prodivder/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  void _handleAddProduct(BuildContext context) {
    Navigator.of(context).pushNamed('/new');
  }

  void _handleSetFavorite(Product product, BuildContext context) {
    print('set favorite');
    context.read<ProductProvider>().setFavorite(product);
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _handleAddProduct(context),
                child: const Text('Thêm sản phẩm'),
              )
            ],
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, value, child) {
                print("DATA CHANGED");
                // print(value);
                final products = value.products;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    return ListTile(
                        title: Text(product.name),
                        trailing: InkWell(
                          child: product.isFavorite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border),
                          onTap: () => _handleSetFavorite(product, context),
                        ));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
